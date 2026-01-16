import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';

class BauhausSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? activeText;
  final String? inactiveText;

  const BauhausSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeText,
    this.inactiveText,
  });

  @override
  State<BauhausSwitch> createState() => _BauhausSwitchState();
}

class _BauhausSwitchState extends State<BauhausSwitch> with SingleTickerProviderStateMixin {
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
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 56,
            height: 32,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color.lerp(
                BauhausDesign.surfaceLight,
                BauhausDesign.primary,
                _animation.value,
              ),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(
                color: BauhausDesign.neutral,
                width: 2.0,
              ),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceLight,
                      borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BauhausDesign.shadowHardSm,
                      ],
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
