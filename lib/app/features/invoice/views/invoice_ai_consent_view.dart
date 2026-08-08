import 'package:carenest/app/features/invoice/views/invoice_ai_dashboard.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Gates the AI-powered invoicing features behind an explicit user consent.
///
/// The first time the user opens the AI dashboard, this screen explains that
/// invoice and client data is sent to Google's Gemini model (via the CareNest
/// backend, using Google Cloud Vertex AI) and asks for consent. The choice is
/// persisted locally so the prompt appears only once.
class InvoiceAIConsentView extends ConsumerWidget {
  final String? organizationId;

  const InvoiceAIConsentView({super.key, this.organizationId});

  static const String _kConsentKey = 'ai_consent_granted';

  static Future<bool> hasConsented() async {
    final prefs = SharedPreferencesUtils();
    await prefs.init();
    return prefs.getBool(_kConsentKey) ?? false;
  }

  static Future<void> saveConsent(bool granted) async {
    final prefs = SharedPreferencesUtils();
    await prefs.init();
    await prefs.setBool(_kConsentKey, granted);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: BauhausDesign.surfaceOffWhite,
              side: const BorderSide(color: BauhausDesign.neutral, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
            ),
          ),
        ),
        title: Text(
          'AI CONSENT',
          style: textTheme.headlineMedium?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    color: BauhausDesign.primary,
                    size: 32,
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Text(
                    'AI-Powered Invoicing uses Google Gemini',
                    style: textTheme.titleLarge?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Text(
                    'To generate, validate, and predict invoices, CareNest '
                    'sends invoice and client information (such as client '
                    'names, email addresses, and billing amounts) to Google\'s '
                    'Gemini model through our secure server (Google Cloud '
                    'Vertex AI).',
                    style: textTheme.bodyMedium?.copyWith(
                      color: BauhausDesign.textDark,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Text(
                    'Google does not use your data to train its models. Your '
                    'information is only used to provide the AI features you '
                    'request.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: BauhausDesign.textDark,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: BauhausDesign.primary,
                        padding: const EdgeInsets.symmetric(
                          vertical: BauhausDesign.space3,
                        ),
                      ),
                      onPressed: () => _accept(context),
                      child: Text(
                        'I AGREE - ENABLE AI FEATURES',
                        style: textTheme.labelLarge?.copyWith(
                          color: BauhausDesign.surfaceWhite,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: BauhausDesign.textDark,
                        side: const BorderSide(
                          color: BauhausDesign.neutral,
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: BauhausDesign.space3,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'NOT NOW',
                        style: textTheme.labelLarge?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
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

  Future<void> _accept(BuildContext context) async {
    await saveConsent(true);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => InvoiceAIDashboard(organizationId: organizationId),
      ),
    );
  }
}
