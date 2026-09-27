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
    final colorScheme = Theme.of(context).colorScheme;
    final activeColor = switch (widget.variant) {
      BauhausSwitchVariant.primary => colorScheme.primary,
      BauhausSwitchVariant.secondary => colorScheme.secondary,
      BauhausSwitchVariant.neutral => colorScheme.inverseSurface,
    };
    final inactiveColor = colorScheme.surface;
    final trackBorderColor = widget.enabled
        ? colorScheme.outline
        : colorScheme.outline.withValues(alpha: 0.3);
    final thumbBorderColor = widget.enabled
        ? colorScheme.outline
        : colorScheme.outline.withValues(alpha: 0.5);

    return GestureDetector(
      onTap: widget.enabled ? () => widget.onChanged(!widget.value) : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final trackColor = Color.lerp(
            inactiveColor,
            activeColor,
            _animation.value,
          )!;
          // The thumb must contrast with the track it sits on. A fixed
          // `colorScheme.surface` thumb disappeared against the dark inactive
          // track in dark mode.
          final thumbColor = BauhausDesign.readableOnColor(trackColor);

          return Container(
            width: 56,
            height: 32,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: trackBorderColor, width: 2.0),
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
                      color: thumbColor,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: thumbBorderColor, width: 2.0),
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
