import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

enum BauhausSwitchVariant { primary, secondary, neutral }

class BauhausSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? activeText;
  final String? inactiveText;
  final BauhausSwitchVariant variant;
  final bool enabled;

  const BauhausSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeText,
    this.inactiveText,
    this.variant = BauhausSwitchVariant.primary,
    this.enabled = true,
  });

  @override
  State<BauhausSwitch> createState() => _BauhausSwitchState();
}

class _BauhausSwitchState extends State<BauhausSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Color get _activeColor {
    switch (widget.variant) {
      case BauhausSwitchVariant.primary:
        return BauhausDesign.primary;
      case BauhausSwitchVariant.secondary:
        return BauhausDesign.secondary;
      case BauhausSwitchVariant.neutral:
        return BauhausDesign.neutral;
    }
  }

  Color get _inactiveColor => BauhausDesign.surfaceWhite;

  Color get _trackBorderColor {
    if (!widget.enabled) return BauhausDesign.neutral.withValues(alpha: 0.3);
    return BauhausDesign.neutral;
  }

  Color get _thumbBorderColor {
    if (!widget.enabled) return BauhausDesign.neutral.withValues(alpha: 0.5);
    return BauhausDesign.neutral;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BauhausSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? () => widget.onChanged(!widget.value) : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 56,
            height: 32,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color.lerp(_inactiveColor, _activeColor, _animation.value),
              borderRadius: BorderRadius.zero,
              border: Border.all(color: _trackBorderColor, width: 2.0),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignment: widget.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceWhite,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: _thumbBorderColor, width: 2.0),
                      boxShadow: const [BauhausDesign.shadowHardSm],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
