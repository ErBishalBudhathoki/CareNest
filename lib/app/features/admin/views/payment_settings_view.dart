import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/invoice/viewmodels/payment_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class PaymentSettingsView extends ConsumerWidget {
  const PaymentSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationState = ref.watch(organizationProvider);
    final organization = organizationState.currentOrganization;
    final isConnected = organization?.stripeAccountId != null &&
        organization!.stripeAccountId!.isNotEmpty;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'PAYMENT SETTINGS',
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
                color: BauhausDesign.textDark,
              ),
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
                  const Icon(Icons.account_balance,
                      color: BauhausDesign.secondary),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Text(
                      'Stripe payout account',
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
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
                      border:
                          Border.all(color: BauhausDesign.neutral, width: 1),
                    ),
                    child: Text(
                      isConnected ? 'CONNECTED' : 'ACTION NEEDED',
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
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
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                  ),
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
                              color: BauhausDesign.neutral, width: 2),
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
                        debugPrint('Connect with Stripe tapped');
                        if (organization == null) {
                          debugPrint('Organization is null');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Error: Organization data missing')),
                          );
                          return;
                        }
                        debugPrint('Organization ID: ${organization.id}');
                        try {
                          final url = await ref
                              .read(paymentViewModelProvider.notifier)
                              .createOnboardingLink(organization.id);
                          debugPrint('Stripe Onboarding URL: $url');
                          if (url != null) {
                            final uri = Uri.parse(url);
                            if (await canLaunchUrl(uri)) {
                              debugPrint('Launching URL: $url');
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              debugPrint('Could not launch URL: $url');
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Could not launch Stripe URL')),
                                );
                              }
                            }
                          } else {
                            debugPrint('Onboarding URL is null');
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Failed to generate onboarding link')),
                              );
                            }
                          }
                        } catch (e) {
                          debugPrint('Error launching Stripe: $e');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BauhausDesign.secondary,
                          border: Border.all(
                              color: BauhausDesign.neutral, width: 2),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Text(
                          'CONNECT WITH STRIPE',
                          style: BauhausDesign.getTextTheme(context)
                              .labelLarge
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
                        // Ideally open Stripe Dashboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Dashboard link not implemented yet')),
                        );
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceLight,
                          border: Border.all(
                              color: BauhausDesign.neutral, width: 2),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Text(
                          'VIEW STRIPE DASHBOARD',
                          style: BauhausDesign.getTextTheme(context)
                              .labelLarge
                              ?.copyWith(
                                color: BauhausDesign.textDark,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
