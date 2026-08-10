import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../constants/onboarding_app_constants.dart';

class OnboardingAppPersonalization extends StatefulWidget {
  final VoidCallback onNext;

  const OnboardingAppPersonalization({super.key, required this.onNext});

  @override
  State<OnboardingAppPersonalization> createState() =>
      _OnboardingAppPersonalizationState();
}

class _OnboardingAppPersonalizationState
    extends State<OnboardingAppPersonalization>
    with SingleTickerProviderStateMixin {
  final _selected = <int>{};
  late final AnimationController _entryCtrl;
  late final Animation<double> _bodyOp;
  late final Animation<Offset> _bodySlide;
  late final List<Animation<double>> _staggeredOps;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: OnboardingDurations.entryFadeSlide,
    );

    _bodyOp = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _bodySlide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entryCtrl,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    final count = OnboardingContent.personalizationOptions.length;
    _staggeredOps = List.generate(count, (i) {
      final start = 0.15 + (i * 0.12);
      final end = (start + 0.55).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _entryCtrl,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    super.dispose();
  }

  void _toggle(int index) {
    setState(() {
      if (_selected.contains(index)) {
        _selected.remove(index);
      } else if (_selected.length < 3) {
        _selected.add(index);
      }
    });
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
            BauhausDesign.space6,
            BauhausDesign.space6,
            BauhausDesign.space6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              const Spacer(),
              SlideTransition(
                position: _bodySlide,
                child: FadeTransition(
                  opacity: _bodyOp,
                  child: Text(
                    'What brings you\nto CareNest?',
                    style: theme.displayMedium?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space3),
              FadeTransition(
                opacity: _bodyOp,
                child: Text(
                  'Choose up to 3. We\'ll tailor your '
                  'experience.',
                  style: theme.bodyLarge?.copyWith(
                    color: BauhausDesign.textMuted,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space8),
              ...List.generate(
                OnboardingContent.personalizationOptions.length,
                (i) {
                  final isSelected = _selected.contains(i);
                  return Padding(
                    padding: EdgeInsets.only(bottom: BauhausDesign.space3),
                    child: AnimatedBuilder(
                      animation: _entryCtrl,
                      builder: (context, _) {
                        return Opacity(
                          opacity: _staggeredOps[i].value,
                          child: _OptionChip(
                            label: OnboardingContent.personalizationOptions[i],
                            isSelected: isSelected,
                            onTap: () => _toggle(i),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const Spacer(),
              _NextButton(enabled: _selected.isNotEmpty, onTap: widget.onNext),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: OnboardingDurations.chipSelect,
        curve: OnboardingCurves.buttonPressEase,
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space4,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? BauhausDesign.primary
              : BauhausDesign.surfaceWhite,
          border: Border.all(
            color: isSelected
                ? BauhausDesign.neoInk
                : BauhausDesign.neoInk.withValues(alpha: 0.6),
            width: isSelected ? 3.0 : 2.0,
          ),
          boxShadow: isSelected
              ? const [BauhausDesign.shadowHard]
              : const [BauhausDesign.shadowHardSm],
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 24,
              color: isSelected
                  ? BauhausDesign.surfaceWhite
                  : BauhausDesign.textMuted,
            ),
            const SizedBox(width: BauhausDesign.space3),
            Text(
              label,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: isSelected
                    ? BauhausDesign.surfaceWhite
                    : BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;

  const _NextButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: OnboardingDurations.chipSelect,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: enabled
                ? BauhausDesign.neoInk
                : BauhausDesign.surfaceOffWhite,
            border: Border.all(
              color: enabled ? BauhausDesign.neoInk : BauhausDesign.textMuted,
              width: 2.5,
            ),
            boxShadow: enabled ? const [BauhausDesign.shadowHard] : const [],
          ),
          child: Text(
            'Continue',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: enabled
                  ? BauhausDesign.surfaceWhite
                  : BauhausDesign.textMuted,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
