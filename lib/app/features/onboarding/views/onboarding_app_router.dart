import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../constants/onboarding_app_constants.dart';
import 'onboarding_app_splash.dart';
import 'onboarding_app_carousel.dart';
import 'onboarding_app_personalization.dart';
import 'onboarding_app_signup.dart';
import 'onboarding_app_complete.dart';

class OnboardingAppRouter extends StatefulWidget {
  final VoidCallback onFinished;

  const OnboardingAppRouter({super.key, required this.onFinished});

  @override
  State<OnboardingAppRouter> createState() => _OnboardingAppRouterState();
}

class _OnboardingAppRouterState extends State<OnboardingAppRouter>
    with SingleTickerProviderStateMixin {
  late final PageController _controller;
  late final AnimationController _progressCtrl;
  int _page = 0;
  String _displayName = '';

  static const int _splash = 0;
  static const int _carousel = 1;
  static const int _personalize = 2;
  static const int _signup = 3;
  static const int _complete = 4;
  static const int _totalSteps = 5;

  double _progressFor(int page) => (page + 1) / _totalSteps;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _progressCtrl = AnimationController(
      vsync: this,
      duration: OnboardingDurations.progressFill,
      value: _progressFor(0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressCtrl.dispose();
    super.dispose();
  }

  void _goForward() {
    if (_page >= _totalSteps - 1) {
      widget.onFinished();
      return;
    }
    _controller.nextPage(
      duration: OnboardingDurations.pageTransition,
      curve: OnboardingCurves.pageEase,
    );
  }

  void _onPageChanged(int page) {
    setState(() => _page = page);
    _progressCtrl.animateTo(
      _progressFor(page),
      duration: OnboardingDurations.progressFill,
      curve: OnboardingCurves.progressEase,
    );
  }

  void _onSignupComplete(String email) {
    final name = email.split('@').first.replaceAll(RegExp(r'[^a-zA-Z]'), ' ');
    final words = name.split(' ').where((w) => w.isNotEmpty);
    _displayName = words.isNotEmpty
        ? '${words.first[0].toUpperCase()}${words.first.substring(1)}'
        : '';
    _controller.nextPage(
      duration: OnboardingDurations.pageTransition,
      curve: OnboardingCurves.pageEase,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: BauhausDesign.space4),
            if (_page > _splash)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space6,
                ),
                child: AnimatedBuilder(
                  animation: _progressCtrl,
                  builder: (context, _) {
                    final p = _progressCtrl.value;
                    return SizedBox(
                      height: 6,
                      child: Row(
                        children: List.generate(_totalSteps, (i) {
                          final segEnd = _progressFor(i);
                          final segStart = i > 0 ? _progressFor(i - 1) : 0.0;
                          final segLen = segEnd - segStart;
                          final raw = segLen > 0
                              ? ((p - segStart) / segLen).clamp(0.0, 1.0)
                              : 0.0;
                          final fill = i < _page ? 1.0 : raw;
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: i > 0 ? 6 : 0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: BauhausDesign.neoInk,
                                  width: 1.5,
                                ),
                                color: fill > 0.0
                                    ? Color.lerp(
                                        BauhausDesign.surfaceWhite,
                                        BauhausDesign.neoInk,
                                        fill.clamp(0.0, 1.0),
                                      )
                                    : BauhausDesign.surfaceWhite,
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            if (_page > _splash) const SizedBox(height: BauhausDesign.space4),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: _onPageChanged,
                physics: _page == _carousel
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                children: [
                  OnboardingAppSplash(onComplete: _goForward),
                  OnboardingAppCarousel(onNext: _goForward),
                  OnboardingAppPersonalization(onNext: _goForward),
                  OnboardingAppSignup(onNext: _goForward),
                  OnboardingAppComplete(
                    displayName: _displayName,
                    onEnter: widget.onFinished,
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
