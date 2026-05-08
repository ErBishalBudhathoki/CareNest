import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../constants/onboarding_app_constants.dart';

class OnboardingAppComplete extends StatefulWidget {
  final String displayName;
  final VoidCallback onEnter;

  const OnboardingAppComplete({
    super.key,
    required this.displayName,
    required this.onEnter,
  });

  @override
  State<OnboardingAppComplete> createState() =>
      _OnboardingAppCompleteState();
}

class _OnboardingAppCompleteState
    extends State<OnboardingAppComplete>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _iconScale;
  late final Animation<double> _bodyOp;
  late final Animation<Offset> _bodySlide;
  late final Animation<double> _ctaOp;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: OnboardingDurations.entryFadeSlide,
    );
    _iconScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.5,
            curve: OnboardingCurves.splashLogoEase),
      ),
    );
    _bodyOp = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );
    _bodySlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.3, 0.8,
            curve: Curves.easeOutCubic),
      ),
    );
    _ctaOp = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
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

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            BauhausDesign.space6,
            BauhausDesign.space8,
            BauhausDesign.space6,
            BauhausDesign.space6,
          ),
          child: Column(
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _iconScale,
                child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: BauhausDesign.success,
                    border: Border.all(
                        color: BauhausDesign.neoInk,
                        width: 3),
                    boxShadow: const [
                      BauhausDesign.shadowHard
                    ],
                  ),
                  child: const Icon(Icons.check,
                      size: 40,
                      color: BauhausDesign.surfaceWhite),
                ),
              ),
              const SizedBox(height: BauhausDesign.space8),
              SlideTransition(
                position: _bodySlide,
                child: FadeTransition(
                  opacity: _bodyOp,
                  child: Column(
                    children: [
                      Text(
                        '${OnboardingContent.completeHeadlinePrefix}${widget.displayName}!',
                        textAlign: TextAlign.center,
                        style: theme.displayMedium?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(
                          height: BauhausDesign.space4),
                      Text(
                        OnboardingContent.completeSubtext,
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
              const Spacer(),
              FadeTransition(
                opacity: _ctaOp,
                child: _BrutalistButton(
                  label: 'Go to Dashboard',
                  onTap: widget.onEnter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrutalistButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _BrutalistButton(
      {required this.label, required this.onTap});

  @override
  State<_BrutalistButton> createState() =>
      _BrutalistButtonState();
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
            end: OnboardingButtonPress.scaleTarget)
        .animate(CurvedAnimation(
            parent: _ctrl,
            curve: OnboardingCurves.buttonPressEase));
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
              vertical: BauhausDesign.space4),
          alignment: Alignment.center,
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
