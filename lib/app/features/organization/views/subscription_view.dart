import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/organization/services/app_subscription_service.dart';
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
  bool _loading = false;
  String? _errorMessage;

  Future<void> _handleSubscribe() async {
    setState(() => _loading = true);
    try {
      final product = await _service.loadMonthlyProduct();
      final purchased = await _service.purchaseMonthly(product);
      if (!purchased) {
        throw StateError(AppLocalizations.of(context)!.subscriptionError);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleRestore() async {
    setState(() => _loading = true);
    try {
      await _service.restorePurchases();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _handleManage() async {
    final uri = Uri.parse('https://play.google.com/store/account/subscriptions');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final organization = ref.watch(organizationProvider).currentOrganization;
    final status = organization == null
        ? null
        : ref.watch(organizationSubscriptionProvider(organization.id));

    final priceText = NumberFormat.simpleCurrency(
      locale: 'en_AU',
      name: 'AUD',
    ).format(9.99);

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
      body: SingleChildScrollView(
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
            _buildPlaceholderCard(context, l10n),
            const SizedBox(height: BauhausDesign.space4),
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                color: BauhausDesign.error.withOpacity(0.08),
                child: Text(
                  _errorMessage!,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.error),
                ),
              ),
            if (_errorMessage != null) const SizedBox(height: BauhausDesign.space4),
            _buildButtons(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, AppLocalizations l10n, AsyncValue<String>? status) {
    final statusText = status?.when(
      data: (value) => value,
      loading: () => null,
      error: (_, __) => null,
    );
    Color color = BauhausDesign.warning;
    String text = l10n.subscriptionStatusUnknown;
    if (statusText == 'active') {
      color = BauhausDesign.success;
      text = l10n.subscriptionStatusActive;
    } else if (statusText == 'grace') {
      color = BauhausDesign.warning;
      text = l10n.subscriptionStatusGrace;
    } else if (statusText == 'expired') {
      color = BauhausDesign.error;
      text = l10n.subscriptionStatusExpired;
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

  Widget _buildPriceCard(BuildContext context, AppLocalizations l10n, String priceText) {
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
                  style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
                    color: BauhausDesign.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.subscriptionDescription,
                  style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            priceText,
            style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
              color: BauhausDesign.primary,
            ),
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
        children: features.map((f) => Padding(
          padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
          child: Row(
            children: [
              const Icon(Icons.check, color: BauhausDesign.success, size: 20),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Text(
                  f,
                  style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildPlaceholderCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.warning, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.subscriptionProductPlaceholder,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              color: BauhausDesign.textMuted,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            l10n.subscriptionIosPlaceholder,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              color: BauhausDesign.textMuted,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            l10n.subscriptionAndroidPlaceholder,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
              color: BauhausDesign.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _loading ? null : _handleSubscribe,
          style: ElevatedButton.styleFrom(
            backgroundColor: BauhausDesign.secondary,
            foregroundColor: BauhausDesign.surfaceLight,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: _loading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Text(l10n.subscriptionBuyButton),
        ),
        const SizedBox(height: BauhausDesign.space3),
        OutlinedButton(
          onPressed: _loading ? null : _handleRestore,
          style: OutlinedButton.styleFrom(
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
      ],
    );
  }
}
