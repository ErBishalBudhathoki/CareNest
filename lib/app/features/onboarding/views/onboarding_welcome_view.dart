import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/onboarding_providers.dart';
import 'onboarding_stepper_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';

class OnboardingWelcomeView extends ConsumerWidget {
  const OnboardingWelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BauhausDesign.surfaceWhite,
      appBar: AppBar(
        title: Text(
          'Welcome to CareNest',
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
      ),
      body: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.people_alt_outlined, size: 80, color: BauhausDesign.primary),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'Complete your onboarding',
              style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              'To get started, we need some details from you. This includes your tax info, superannuation, and required documents.',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textMuted,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ButtonWidget(
              buttonText: 'Start Onboarding',
              onPressed: () {
                // Initialize loading of status
                ref.read(onboardingViewModelProvider.notifier).loadStatus();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const OnboardingStepperView()),
                );
              },
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],
        ),
      ),
    );
  }
}
