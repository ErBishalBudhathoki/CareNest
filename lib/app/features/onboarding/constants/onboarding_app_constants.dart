import 'package:flutter/material.dart';

/// Animation timing constants for the app-intro onboarding flow.
///
/// All values align with the 8-pt grid where possible.
abstract class OnboardingDurations {
  OnboardingDurations._();

  static const Duration pageTransition = Duration(milliseconds: 380);
  static const Duration splashLogo = Duration(milliseconds: 700);
  static const Duration splashTaglineDelay = Duration(milliseconds: 400);
  static const Duration splashTagline = Duration(milliseconds: 500);
  static const Duration splashAutoAdvance = Duration(milliseconds: 2200);
  static const Duration staggerHeadline = Duration(milliseconds: 150);
  static const Duration staggerSubtext = Duration(milliseconds: 250);
  static const Duration staggerCta = Duration(milliseconds: 400);
  static const Duration buttonPress = Duration(milliseconds: 120);
  static const Duration chipSelect = Duration(milliseconds: 200);
  static const Duration progressFill = Duration(milliseconds: 300);
  static const Duration entryFadeSlide = Duration(milliseconds: 500);
}

/// Animation curves used throughout the onboarding flow.
abstract class OnboardingCurves {
  OnboardingCurves._();

  static const Cubic pageEase = Curves.easeInOutCubic;
  static const Cubic entryEase = Curves.easeOutCubic;
  static const ElasticInOutCurve splashLogoEase = ElasticInOutCurve(0.5);
  static const Cubic buttonPressEase = Curves.easeInOutCubic;
  static const Cubic progressEase = Curves.easeInOutCubic;
}

/// Button press transform values.
abstract class OnboardingButtonPress {
  OnboardingButtonPress._();

  static const double scaleTarget = 0.96;
  static const double normalScale = 1.0;
  static const double shadowOffsetNormal = 4.0;
  static const double shadowOffsetPressed = 2.0;
}

/// Content constants for the onboarding slides.
abstract class OnboardingContent {
  OnboardingContent._();

  static const String appName = 'CareNest';
  static const String tagline = 'Smart care management\nfor NDIS providers';

  static const List<_Slide> carouselSlides = [
    _Slide(
      icon: Icons.receipt_long,
      headline: 'Invoice in seconds,\nnot hours',
      subtext:
          'Generate NDIS-compliant invoices with automatic '
          'pricing, bulk actions, and one-tap sharing.',
    ),
    _Slide(
      icon: Icons.calendar_month,
      headline: 'Schedule with\nconfidence',
      subtext:
          'Drag-and-drop rostering with real-time availability, '
          'conflict detection, and calendar sync.',
    ),
    _Slide(
      icon: Icons.insights,
      headline: 'Know your numbers\nin real time',
      subtext:
          'Revenue forecasts, cash flow predictions, and '
          'payroll dashboards all in one place.',
    ),
  ];

  static const List<String> personalizationOptions = [
    'I manage a team',
    'I work directly with clients',
    'I handle billing & payroll',
  ];

  static const String signupHeadline = 'Create your\naccount';
  static const String signupSubtext =
      'Join thousands of NDIS providers '
      'already using CareNest.';

  static const String completeHeadlinePrefix = 'Ready to go, ';
  static const String completeSubtext =
      'Your account is set up. Start exploring CareNest '
      'and see how much time you can save.';
}

class _Slide {
  final IconData icon;
  final String headline;
  final String subtext;
  const _Slide({
    required this.icon,
    required this.headline,
    required this.subtext,
  });
}

IconData carouselIcon(int i) => OnboardingContent.carouselSlides[i].icon;
String carouselHeadline(int i) => OnboardingContent.carouselSlides[i].headline;
String carouselSubtext(int i) => OnboardingContent.carouselSlides[i].subtext;
int get carouselSlideCount => OnboardingContent.carouselSlides.length;
