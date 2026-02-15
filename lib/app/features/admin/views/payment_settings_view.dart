import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/invoice/viewmodels/payment_viewmodel.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';

class PaymentSettingsView extends ConsumerWidget {
  const PaymentSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationState = ref.watch(organizationProvider);
    final organization = organizationState.currentOrganization;
    final isConnected = organization?.stripeAccountId != null && organization!.stripeAccountId!.isNotEmpty;

    return Scaffold(
      backgroundColor: BauhausTheme.white,
      appBar: AppBar(
        title: Text('PAYMENT SETTINGS', style: BauhausTheme.headerStyle.copyWith(fontSize: 20)),
        backgroundColor: BauhausTheme.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausTheme.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(color: BauhausTheme.black, height: 2.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: BauhausTheme.blockPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connect with Stripe',
              style: BauhausTheme.subHeaderStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'Link your bank account to receive payments directly from clients. '
              'We use Stripe Connect to ensure secure and compliant payouts for your NDIS business.',
              style: BauhausTheme.bodyStyle.copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BauhausTheme.blockDecoration,
              padding: BauhausTheme.blockPadding,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isConnected ? const Color(0xFF00A651) : BauhausTheme.yellow, // Green or Yellow
                          border: Border.all(color: BauhausTheme.black, width: 2),
                        ),
                        child: Icon(
                          isConnected ? Icons.check : Icons.link,
                          color: BauhausTheme.black,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isConnected ? 'ACCOUNT CONNECTED' : 'NOT CONNECTED',
                              style: BauhausTheme.labelStyle,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isConnected 
                                ? 'Your Stripe account is active and ready to receive payouts.'
                                : 'Connect your account to start accepting payments.',
                              style: BauhausTheme.bodyStyle.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (!isConnected)
                    InkWell(
                      onTap: () async {
                        debugPrint('Connect with Stripe tapped');
                        if (organization == null) {
                           debugPrint('Organization is null');
                           ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error: Organization data missing')),
                           );
                           return;
                        }
                        debugPrint('Organization ID: ${organization.id}');
                        try {
                          final url = await ref.read(paymentViewModelProvider.notifier).createOnboardingLink(organization.id);
                          debugPrint('Stripe Onboarding URL: $url');
                          if (url != null) {
                            final uri = Uri.parse(url);
                            if (await canLaunchUrl(uri)) {
                              debugPrint('Launching URL: $url');
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            } else {
                              debugPrint('Could not launch URL: $url');
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Could not launch Stripe URL')),
                                );
                              }
                            }
                          } else {
                             debugPrint('Onboarding URL is null');
                             if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Failed to generate onboarding link')),
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
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BauhausTheme.blue,
                          border: Border.all(color: BauhausTheme.black, width: 2),
                        ),
                        child: Text(
                          'CONNECT WITH STRIPE',
                          style: BauhausTheme.bodyStyle.copyWith(color: BauhausTheme.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    )
                  else
                     InkWell(
                      onTap: () {
                        // Ideally open Stripe Dashboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Dashboard link not implemented yet')),
                        );
                      },
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BauhausTheme.white,
                          border: Border.all(color: BauhausTheme.black, width: 2),
                        ),
                        child: Text(
                          'VIEW STRIPE DASHBOARD',
                          style: BauhausTheme.bodyStyle.copyWith(color: BauhausTheme.black, fontWeight: FontWeight.w900),
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
