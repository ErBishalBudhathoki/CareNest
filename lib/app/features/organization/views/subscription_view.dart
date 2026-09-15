import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/organization/services/app_subscription_service.dart';
import 'package:carenest/app/features/invoice/repositories/payment_repository.dart';
import 'package:carenest/config/build_config.dart';
import 'package:carenest/app/shared/widgets/app_snack_bars.dart';
import 'package:carenest/app/shared/utils/user_messages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/invoice/viewmodels/payment_viewmodel.dart';

class SubscriptionView extends ConsumerStatefulWidget {
  const SubscriptionView({super.key});

  @override
  ConsumerState<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends ConsumerState<SubscriptionView> {
  final AppSubscriptionService _service = AppSubscriptionService();
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;
  ProductDetails? _product;
  bool _loading = false;
  String? _errorMessage;
  bool _purchaseHandled = false;

  @override
  void initState() {
    super.initState();
    _purchaseSubscription = _service.purchaseUpdates.listen(
      _onPurchaseUpdates,
      onError: (Object e) {
        if (mounted) setState(() => _errorMessage = e.toString());
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadProduct());
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadProduct() async {
    try {
      final product = await _service.loadMonthlyProduct();
      if (mounted) {
        setState(() {
          _product = product;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(
          () => _errorMessage = friendlyErrorMessage(
            e,
            fallback: 'Subscriptions are unavailable right now.',
          ),
        );
      }
    }
  }

  /// Resolve the organisation id from the most reliable available source.
  /// `organizationProvider.currentOrganization` can be null depending on which
  /// screen the user came from, which previously broke purchase verification.
  String? _resolveOrganizationId() {
    final fromOrg = ref.read(organizationProvider).currentOrganization?.id;
    if (fromOrg != null && fromOrg.trim().isNotEmpty) return fromOrg.trim();

    try {
      final fromProvider = ref.read(app_providers.organizationIdProvider);
      if (fromProvider != null && fromProvider.trim().isNotEmpty) {
        return fromProvider.trim();
      }
    } catch (_) {}

    try {
      final fromPrefs = ref
          .read(app_providers.sharedPreferencesProvider)
          .getOrganizationId();
      if (fromPrefs != null && fromPrefs.trim().isNotEmpty) {
        return fromPrefs.trim();
      }
    } catch (_) {}

    return null;
  }

  Future<void> _onPurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      await _processPurchase(purchase);
    }
  }

  Future<void> _processPurchase(PurchaseDetails purchase) async {
    switch (purchase.status) {
      case PurchaseStatus.purchased:
      case PurchaseStatus.restored:
        await _verifyAndActivate(purchase);
        break;
      case PurchaseStatus.error:
        final code = purchase.error?.code ?? '';
        debugPrint(
          '[subscription] purchase error code=$code '
          'message=${purchase.error?.message}',
        );
        if (mounted) {
          setState(() {
            _purchaseHandled = true;
            _errorMessage = friendlyErrorMessage(
              purchase.error?.message,
              fallback:
                  'The Play Store could not complete the purchase. Please try again.',
            );
            _loading = false;
          });
        }
        // The account may already own the subscription (e.g. after a previous
        // test purchase). Restore it so we can verify and activate.
        try {
          await _service.restorePurchases();
        } catch (_) {}
        break;
      case PurchaseStatus.canceled:
        if (mounted) setState(() => _loading = false);
        break;
      case PurchaseStatus.pending:
        // Keep the loading indicator until the store responds.
        break;
    }
  }

  Future<void> _verifyAndActivate(PurchaseDetails purchase) async {
    final organizationId = _resolveOrganizationId();
    try {
      if (organizationId == null) {
        throw StateError('Organization data is unavailable');
      }
      final repository = ref.read(paymentRepositoryProvider);
      final verificationToken =
          purchase.verificationData.serverVerificationData;

      final Map<String, dynamic> result;
      if (Platform.isAndroid) {
        result = await repository.verifyGooglePurchase(
          organizationId: organizationId,
          purchaseToken: verificationToken,
          productId: purchase.productID,
          subscriptionId: purchase.productID,
        );
      } else {
        result = await repository.verifyApplePurchase(
          organizationId: organizationId,
          transactionJws: verificationToken,
          productId: purchase.productID,
        );
      }

      if (result['success'] != true) {
        throw StateError(
          result['message']?.toString() ?? 'Subscription verification failed',
        );
      }

      await _service.completeVerifiedPurchase(purchase);
      ref.invalidate(organizationSubscriptionProvider(organizationId));

      if (mounted) {
        setState(() {
          _purchaseHandled = true;
          _loading = false;
          _errorMessage = null;
        });
        showSuccessSnack(
          context,
          'Your subscription is active. All features are unlocked.',
        );
      }
    } catch (e) {
      // Do NOT acknowledge on failure. Leaving the purchase unacknowledged lets
      // Play redeliver it on restore/next launch so verification can be retried,
      // and Play auto-refunds if it is never acknowledged.
      if (mounted) {
        setState(() {
          _purchaseHandled = true;
          _loading = false;
          _errorMessage = friendlyErrorMessage(e);
        });
      }
    }
  }

  Future<bool> _confirmSubscribe() async {
    final theme = BauhausDesign.getTextTheme(context);
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: BauhausDesign.neutral.withValues(alpha: 0.55),
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(BauhausDesign.space4),
        child: Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space2),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceWhite,
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusSm,
                      ),
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.receipt_long_outlined,
                      color: BauhausDesign.textDark,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Text(
                      'CONFIRM SUBSCRIPTION',
                      style: theme.labelLarge?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'This purchase is completed through Google Play.',
                style: theme.bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                'If your Google account is set up as a Play license tester you will '
                'NOT be charged. Otherwise Google Play will charge your saved payment '
                'method and the subscription renews until you cancel it.',
                style: theme.bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: BauhausDesign.textDark,
                        side: const BorderSide(
                          color: BauhausDesign.neutral,
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            BauhausDesign.radiusMd,
                          ),
                        ),
                      ),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BauhausDesign.secondary,
                        foregroundColor: BauhausDesign.surfaceWhite,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            BauhausDesign.radiusMd,
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.pop(dialogContext, true),
                      child: const Text(
                        'CONTINUE',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return confirmed == true;
  }

  Future<void> _handleSubscribe() async {
    if (!await _confirmSubscribe()) return;
    if (!mounted) return;
    setState(() {
      _loading = true;
      _errorMessage = null;
      _purchaseHandled = false;
    });
    try {
      final product = _product ?? await _service.loadMonthlyProduct();
      _product = product;
      final started = await _service.purchaseMonthly(product);
      if (!started && mounted) {
        setState(() => _loading = false);
      }
      // Completion is delivered via the purchase stream.
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = friendlyErrorMessage(
            e,
            fallback: 'We could not start the purchase. Please try again.',
          );
          _loading = false;
        });
      }
    }
  }

  Future<void> _handleRestore() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _purchaseHandled = false;
    });
    try {
      await _service.restorePurchases();
      // Restored purchases are delivered asynchronously via the stream.
      await Future<void>.delayed(const Duration(seconds: 5));
      if (mounted && !_purchaseHandled) {
        setState(() {
          _loading = false;
          _errorMessage =
              'No active subscription found to restore on this account.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = friendlyErrorMessage(
            e,
            fallback: 'We could not restore your purchases. Please try again.',
          );
          _loading = false;
        });
      }
    }
  }

  Future<void> _handleDevReset() async {
    final organizationId = _resolveOrganizationId();
    if (organizationId == null) {
      showErrorSnack(
        context,
        'We could not load your organisation. Please reopen the screen.',
      );
      return;
    }
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      final result = await ref
          .read(paymentRepositoryProvider)
          .resetSubscription(organizationId);
      if (result['success'] != true) {
        throw StateError(result['message']?.toString() ?? 'Reset failed');
      }
      ref.invalidate(organizationSubscriptionProvider(organizationId));
      if (mounted) {
        showSuccessSnack(
          context,
          'Subscription reset (dev build). You can subscribe again.',
        );
      }
    } catch (e) {
      if (mounted) {
        showErrorSnack(
          context,
          friendlyErrorMessage(
            e,
            fallback: 'Could not reset the subscription. Please try again.',
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleManage() async {
    final uri = Platform.isIOS
        ? Uri.parse('https://apps.apple.com/account/subscriptions')
        : Uri.parse('https://play.google.com/store/account/subscriptions');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final organizationId = _resolveOrganizationId();
    final status = organizationId == null
        ? null
        : ref.watch(organizationSubscriptionProvider(organizationId));
    final statusValue = status?.asData?.value;
    final isActive = statusValue == 'active' || statusValue == 'grace';

    final priceText = _product?.price ?? l10n.subscriptionPricePerMonth;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          l10n.subscriptionTitle,
          style: BauhausDesign.getTextTheme(
            context,
          ).displaySmall?.copyWith(color: BauhausDesign.textDark),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(color: BauhausDesign.neutral, height: 2.0),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final orgId = _resolveOrganizationId();
          if (orgId != null) {
            ref.invalidate(organizationSubscriptionProvider(orgId));
          }
          await _loadProduct();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusBanner(context, l10n, status),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                l10n.subscriptionDescription,
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: BauhausDesign.textDark),
              ),
              const SizedBox(height: BauhausDesign.space4),
              _buildPriceCard(context, l10n, priceText),
              const SizedBox(height: BauhausDesign.space4),
              _buildFeaturesList(context, l10n),
              const SizedBox(height: BauhausDesign.space4),
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  color: BauhausDesign.error.withValues(alpha: 0.08),
                  child: Text(
                    _errorMessage!,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodySmall?.copyWith(color: BauhausDesign.error),
                  ),
                ),
              if (_errorMessage != null)
                const SizedBox(height: BauhausDesign.space4),
              _buildButtons(context, l10n, isActive: isActive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBanner(
    BuildContext context,
    AppLocalizations l10n,
    AsyncValue<String>? status,
  ) {
    final statusText = status?.when(
      data: (value) => value,
      loading: () => null,
      error: (_, _) => null,
    );
    Color color = BauhausDesign.warning;
    String text = l10n.subscriptionStatusUnknown;
    if (statusText == 'active') {
      color = BauhausDesign.success;
      text = l10n.subscriptionStatusActive;
    } else if (statusText == 'grace') {
      color = BauhausDesign.warning;
      text = l10n.subscriptionStatusGrace;
    } else if (statusText == 'expired' ||
        statusText == 'revoked' ||
        statusText == 'refunded') {
      color = BauhausDesign.error;
      text = l10n.subscriptionStatusExpired;
    } else if (statusText == 'none') {
      color = BauhausDesign.warning;
      text = l10n.subscriptionStatusUnknown;
    }
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: color, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          Icon(
            statusText == 'active' ? Icons.check_circle : Icons.error_outline,
            color: color,
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Text(
              text,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(
    BuildContext context,
    AppLocalizations l10n,
    String priceText,
  ) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.subscriptionPricePerMonth,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: BauhausDesign.textDark),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.subscriptionDescription,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                ),
              ],
            ),
          ),
          Text(
            priceText,
            style: BauhausDesign.getTextTheme(
              context,
            ).displaySmall?.copyWith(color: BauhausDesign.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context, AppLocalizations l10n) {
    final features = [
      l10n.subscriptionFeature1,
      l10n.subscriptionFeature2,
      l10n.subscriptionFeature3,
      l10n.subscriptionFeature4,
    ];
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: features
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check,
                      color: BauhausDesign.success,
                      size: 20,
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Text(
                        f,
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).bodyMedium?.copyWith(color: BauhausDesign.textDark),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildButtons(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isActive,
  }) {
    final theme = BauhausDesign.getTextTheme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          // Already subscribed: don't offer another purchase.
          onPressed: (_loading || isActive) ? null : _handleSubscribe,
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive
                ? BauhausDesign.surfaceOffWhite
                : BauhausDesign.secondary,
            foregroundColor: isActive
                ? BauhausDesign.textMuted
                : BauhausDesign.surfaceLight,
            disabledBackgroundColor: BauhausDesign.surfaceOffWhite,
            disabledForegroundColor: BauhausDesign.textMuted,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: _loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  isActive ? 'SUBSCRIPTION ACTIVE' : l10n.subscriptionBuyButton,
                  style: theme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: isActive
                        ? BauhausDesign.textMuted
                        : BauhausDesign.surfaceLight,
                  ),
                ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        OutlinedButton(
          onPressed: _loading ? null : _handleRestore,
          style: OutlinedButton.styleFrom(
            foregroundColor: BauhausDesign.textDark,
            side: const BorderSide(color: BauhausDesign.neutral, width: 2),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(l10n.subscriptionRestoreButton),
        ),
        const SizedBox(height: BauhausDesign.space3),
        TextButton(
          onPressed: _loading ? null : _handleManage,
          child: Text(l10n.subscriptionManageButton),
        ),
        if (BuildConfig.enableDevSubscriptionReset) ...[
          const SizedBox(height: BauhausDesign.space4),
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              border: Border.all(color: BauhausDesign.neutral, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DEV TOOLS',
                  style: theme.labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _loading ? null : _handleDevReset,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: BauhausDesign.textDark,
                      side: const BorderSide(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text('RESET SUBSCRIPTION (DEV)'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
