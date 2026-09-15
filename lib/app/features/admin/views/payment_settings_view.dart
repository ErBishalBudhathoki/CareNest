import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/viewmodels/payment_viewmodel.dart';
import 'package:carenest/app/features/organization/views/subscription_view.dart';
import 'package:carenest/app/shared/widgets/app_snack_bars.dart';
import 'package:carenest/app/shared/utils/user_messages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class PaymentSettingsView extends ConsumerStatefulWidget {
  const PaymentSettingsView({super.key});

  @override
  ConsumerState<PaymentSettingsView> createState() =>
      _PaymentSettingsViewState();
}

class _PaymentSettingsViewState extends ConsumerState<PaymentSettingsView>
    with WidgetsBindingObserver {
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final orgId = _resolveOrganizationId();
      if (orgId != null) {
        ref.invalidate(stripeConnectStatusProvider(orgId));
        ref.invalidate(organizationSubscriptionProvider(orgId));
      }
    }
  }

  /// Resolve the org id even when `organizationProvider.currentOrganization`
  /// has not been loaded, so both cards show the correct live state.
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

  @override
  Widget build(BuildContext context) {
    final organizationState = ref.watch(organizationProvider);
    final organization = organizationState.currentOrganization;
    final organizationId = _resolveOrganizationId();
    _organizationId = organizationId;
    final connectStatus = organizationId == null
        ? null
        : ref.watch(stripeConnectStatusProvider(organizationId));
    final isConnected = connectStatus?.asData?.value == true;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'PAYMENT SETTINGS',
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
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceLight,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_balance,
                    color: BauhausDesign.secondary,
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Text(
                      'Stripe payout account',
                      style: BauhausDesign.getTextTheme(context).bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space2,
                      vertical: BauhausDesign.space1,
                    ),
                    decoration: BoxDecoration(
                      color: isConnected
                          ? BauhausDesign.success
                          : BauhausDesign.warning,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      isConnected ? 'CONNECTED' : 'ACTION NEEDED',
                      style: BauhausDesign.getTextTheme(context).labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'Connect with Stripe',
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Link your bank account to receive payments directly from clients. '
              'We use Stripe Connect to ensure secure and compliant payouts for your NDIS business.',
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyMedium?.copyWith(color: BauhausDesign.textDark),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceLight,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isConnected
                              ? BauhausDesign.success
                              : BauhausDesign.warning,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          isConnected ? Icons.check : Icons.link,
                          color: BauhausDesign.textDark,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isConnected
                                  ? 'ACCOUNT CONNECTED'
                                  : 'NOT CONNECTED',
                              style: BauhausDesign.getTextTheme(context)
                                  .labelLarge
                                  ?.copyWith(
                                    color: BauhausDesign.textDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isConnected
                                  ? 'Your Stripe account is active and ready to receive payouts.'
                                  : 'Connect your account to start accepting payments.',
                              style: BauhausDesign.getTextTheme(context)
                                  .bodySmall
                                  ?.copyWith(color: BauhausDesign.textMuted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  if (!isConnected)
                    InkWell(
                      onTap: () async {
                        if (organizationId == null) {
                          showErrorSnack(
                            context,
                            'We could not load your organisation. Please reopen the screen.',
                          );
                          return;
                        }
                        try {
                          final url = await ref
                              .read(paymentViewModelProvider.notifier)
                              .createOnboardingLink(organizationId);
                          final uri = Uri.tryParse(url);
                          if (uri == null ||
                              !await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              )) {
                            throw Exception('Could not launch Stripe URL');
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showErrorSnack(context, friendlyStripeError(e));
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BauhausDesign.secondary,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 2,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Text(
                          'CONNECT WITH STRIPE',
                          style: BauhausDesign.getTextTheme(context).labelLarge
                              ?.copyWith(
                                color: BauhausDesign.surfaceLight,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () {
                        showInfoSnack(
                          context,
                          'Open your Stripe Dashboard in a browser to manage payouts.',
                        );
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceLight,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 2,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Text(
                          'VIEW STRIPE DASHBOARD',
                          style: BauhausDesign.getTextTheme(context).labelLarge
                              ?.copyWith(
                                color: BauhausDesign.textDark,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    ),
                  if (isConnected) ...[
                    const SizedBox(height: BauhausDesign.space3),
                    InkWell(
                      onTap: () =>
                          _confirmDisconnectStripe(context, organizationId!),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceLight,
                          border: Border.all(
                            color: BauhausDesign.error,
                            width: 2,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Text(
                          'DISCONNECT STRIPE',
                          style: BauhausDesign.getTextTheme(context).labelLarge
                              ?.copyWith(
                                color: BauhausDesign.error,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            _buildSubscriptionCard(context, organizationId),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDisconnectStripe(
    BuildContext context,
    String organizationId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        title: const Text('Disconnect Stripe?'),
        content: const Text(
          'This will remove the linked Stripe account. Clients will no longer '
          'be able to pay invoices online until you reconnect.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.error,
              foregroundColor: BauhausDesign.surfaceWhite,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('DISCONNECT'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref
          .read(paymentViewModelProvider.notifier)
          .disconnectStripe(organizationId);
      if (mounted) {
        showSuccessSnack(context, 'Stripe account disconnected.');
        ref.invalidate(stripeConnectStatusProvider(organizationId));
      }
    } catch (e) {
      if (mounted) {
        showErrorSnack(context, friendlyStripeError(e));
      }
    }
  }

  Widget _buildSubscriptionCard(BuildContext context, String? organizationId) {
    final status = organizationId == null
        ? null
        : ref.watch(organizationSubscriptionProvider(organizationId));
    final statusText = status?.when(
      data: (value) => value,
      loading: () => null,
      error: (_, _) => null,
    );
    final isActive = statusText == 'active' || statusText == 'grace';
    final statusLabel = isActive
        ? 'ACTIVE'
        : (statusText == null ? 'UNKNOWN' : statusText.toUpperCase());

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'APP SUBSCRIPTION',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? BauhausDesign.success
                      : BauhausDesign.warning,
                  border: Border.all(color: BauhausDesign.neutral, width: 1),
                ),
                child: Text(
                  statusLabel,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            'Activate your CareNest subscription to unlock invoicing, payments, '
            'scheduling and timesheets. Subscriptions are handled by the app store.',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
          ),
          const SizedBox(height: BauhausDesign.space3),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SubscriptionView()),
              );
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: BauhausDesign.secondary,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: Text(
                isActive ? 'MANAGE SUBSCRIPTION' : 'SUBSCRIBE',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.surfaceLight,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
