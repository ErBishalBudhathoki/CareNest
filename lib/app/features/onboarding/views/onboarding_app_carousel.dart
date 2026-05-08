import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../constants/onboarding_app_constants.dart';

class OnboardingAppCarousel extends StatefulWidget {
  final VoidCallback onNext;

  const OnboardingAppCarousel({super.key, required this.onNext});

  @override
  State<OnboardingAppCarousel> createState() => _OnboardingAppCarouselState();
}

class _OnboardingAppCarouselState extends State<OnboardingAppCarousel>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _progressAnimator;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressAnimator = AnimationController(
      vsync: this,
      duration: OnboardingDurations.progressFill,
      value: _segEnd(0),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressAnimator.dispose();
    super.dispose();
  }

  double _segEnd(int page) => (page + 1) / carouselSlideCount;

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    _progressAnimator.animateTo(
      _segEnd(page),
      duration: OnboardingDurations.progressFill,
      curve: OnboardingCurves.progressEase,
    );
  }

  void _advance() {
    if (_currentPage < carouselSlideCount - 1) {
      _pageController.nextPage(
        duration: OnboardingDurations.pageTransition,
        curve: OnboardingCurves.pageEase,
      );
    } else {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            BauhausDesign.space6,
            BauhausDesign.space4,
            BauhausDesign.space6,
            BauhausDesign.space6,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: widget.onNext,
                  child: Padding(
                    padding: const EdgeInsets.all(BauhausDesign.space2),
                    child: Text(
                      'Skip',
                      style: BauhausDesign.neoMonoStyle(
                        context,
                        color: BauhausDesign.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              AnimatedBuilder(
                animation: _progressAnimator,
                builder: (context, _) {
                  final p = _progressAnimator.value;
                  return SizedBox(
                    height: 8,
                    child: Row(
                      children: List.generate(carouselSlideCount, (i) {
                        final segStart =
                            i > 0 ? _segEnd(i - 1) : 0.0;
                        final segLen = _segEnd(i) - segStart;
                        final raw = segLen > 0
                            ? ((p - segStart) / segLen)
                                .clamp(0.0, 1.0)
                            : 0.0;
                        final fill =
                            i < _currentPage ? 1.0 : raw;
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: i > 0 ? 6 : 0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: BauhausDesign.neoInk,
                                  width: 1.5),
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
              const SizedBox(height: BauhausDesign.space8),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: carouselSlideCount,
                  itemBuilder: (context, index) {
                    return _CarouselSlide(
                      icon: carouselIcon(index),
                      headline: carouselHeadline(index),
                      subtext: carouselSubtext(index),
                    );
                  },
                ),
              ),
              const SizedBox(height: BauhausDesign.space6),
              _BrutalistButton(
                label: _currentPage == carouselSlideCount - 1
                    ? 'Get Started'
                    : 'Continue',
                onTap: _advance,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CarouselSlide extends StatefulWidget {
  final IconData icon;
  final String headline;
  final String subtext;

  const _CarouselSlide({
    required this.icon,
    required this.headline,
    required this.subtext,
  });

  @override
  State<_CarouselSlide> createState() => _CarouselSlideState();
}

class _CarouselSlideState extends State<_CarouselSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _iconScale;
  late final Animation<double> _bodyOpacity;
  late final Animation<Offset> _bodySlide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: OnboardingDurations.entryFadeSlide,
    );
    _iconScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );
    _bodyOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
    _bodySlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BauhausDesign.getTextTheme(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _iconScale,
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(
                    color: BauhausDesign.neoInk, width: 2.5),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Icon(widget.icon,
                  size: 36, color: BauhausDesign.neoInk),
            ),
          ),
          const SizedBox(height: BauhausDesign.space10),
          SlideTransition(
            position: _bodySlide,
            child: FadeTransition(
              opacity: _bodyOpacity,
              child: Column(
                children: [
                  Text(
                    widget.headline,
                    textAlign: TextAlign.center,
                    style: theme.displayMedium?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  Text(
                    widget.subtext,
                    textAlign: TextAlign.center,
                    style: theme.bodyLarge?.copyWith(
                      color: BauhausDesign.textMuted,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrutalistButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _BrutalistButton({required this.label, required this.onTap});

  @override
  State<_BrutalistButton> createState() => _BrutalistButtonState();
}

class _BrutalistButtonState extends State<_BrutalistButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: OnboardingDurations.buttonPress,
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: OnboardingButtonPress.scaleTarget,
    ).animate(CurvedAnimation(
        parent: _ctrl, curve: OnboardingCurves.buttonPressEase));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    setState(() => _pressed = true);
    _ctrl.forward();
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _pressed = false);
    _ctrl.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _pressed = false);
    _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final shadowOffset = _pressed
        ? OnboardingButtonPress.shadowOffsetPressed
        : 4.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: OnboardingDurations.buttonPress,
          curve: OnboardingCurves.buttonPressEase,
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space8,
            vertical: BauhausDesign.space4,
          ),
          decoration: BoxDecoration(
            color: BauhausDesign.neoInk,
            border: Border.all(
                color: BauhausDesign.neoInk, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000),
                offset: Offset(shadowOffset, shadowOffset),
                blurRadius: 0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: BauhausDesign.getTextTheme(context)
                .labelLarge
                ?.copyWith(
                  color: BauhausDesign.surfaceWhite,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
          ),
        ),
      ),
    );
  }
}
