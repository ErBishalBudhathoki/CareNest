import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../constants/onboarding_app_constants.dart';

class OnboardingAppSplash extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingAppSplash({super.key, required this.onComplete});

  @override
  State<OnboardingAppSplash> createState() => _OnboardingAppSplashState();
}

class _OnboardingAppSplashState extends State<OnboardingAppSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _taglineOpacity;
  late final Animation<Offset> _taglineSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: OnboardingDurations.splashLogo,
    );

    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: OnboardingCurves.splashLogoEase),
      ),
    );

    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
      ),
    );

    _taglineSlide =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.55, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _controller.forward();
    Future.delayed(OnboardingDurations.splashAutoAdvance, () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(scale: _logoScale, child: const _LogoMark()),
              const SizedBox(height: BauhausDesign.space6),
              SlideTransition(
                position: _taglineSlide,
                child: FadeTransition(
                  opacity: _taglineOpacity,
                  child: Text(
                    OnboardingContent.tagline,
                    textAlign: TextAlign.center,
                    style: theme.headlineLarge?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: BauhausDesign.primary,
        border: Border.all(color: BauhausDesign.neoInk, width: 3),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Text(
        OnboardingContent.appName[0],
        style: BauhausDesign.getTextTheme(context).displayLarge?.copyWith(
          color: BauhausDesign.surfaceWhite,
          fontWeight: FontWeight.w900,
          fontSize: 48,
        ),
      ),
    );
  }
}
