import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import '../providers/onboarding_providers.dart';

class OnboardingWelcomeView extends ConsumerStatefulWidget {
  const OnboardingWelcomeView({super.key});

  @override
  ConsumerState<OnboardingWelcomeView> createState() =>
      _OnboardingWelcomeViewState();
}

class _OnboardingWelcomeViewState extends ConsumerState<OnboardingWelcomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingViewModelProvider.notifier).loadStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Employee onboarding',
                        textAlign: TextAlign.center,
                        style: theme.labelLarge?.copyWith(
                          color: BauhausDesign.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      height: 260,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFF1F6FF), Color(0xFFF8FAFF)],
                        ),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: SvgPicture.asset(
                        'assets/ui_assets_svg/onboarding_welcome.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Complete your profile before your first shift',
                      style: theme.headlineMedium?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Add your payroll, tax, superannuation, and compliance details so your account can be approved and ready for work.',
                      style: theme.bodyLarge?.copyWith(
                        color: BauhausDesign.textMuted,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _WelcomePoint(
                      title: 'One screen at a time',
                      body:
                          'Work through your profile in clear steps without jumping across tabs.',
                    ),
                    const SizedBox(height: 12),
                    _WelcomePoint(
                      title: 'Restart from the beginning',
                      body:
                          'If you leave mid-way, you will still see this welcome screen again before continuing.',
                    ),
                    const SizedBox(height: 12),
                    _WelcomePoint(
                      title: 'Submit everything in app',
                      body:
                          'Upload identity and training documents directly from your device.',
                    ),
                  ],
                ),
              ),
              ButtonWidget(
                buttonText: 'Start Onboarding',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.onboardingStepper,
                    arguments: const {'restartFromBeginning': true},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomePoint extends StatelessWidget {
  const _WelcomePoint({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = BauhausDesign.getTextTheme(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
            color: BauhausDesign.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.bodyMedium?.copyWith(
                color: BauhausDesign.textMuted,
                height: 1.45,
              ),
              children: [
                TextSpan(
                  text: '$title. ',
                  style: theme.bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
