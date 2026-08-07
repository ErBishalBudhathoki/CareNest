import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BauhausSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const BauhausSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 32,
        decoration: BoxDecoration(
          color: value ? BauhausDesign.primary : BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(
            BauhausDesign.radiusSm,
          ), // Squarish rounded corners
          border: Border.all(color: BauhausDesign.neutral, width: 2.0),
          boxShadow: const [
            BauhausDesign.shadowHardXs,
          ], // Subtle hard shadow for depth
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 24.0 : 4.0,
              top: 4.0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: value
                      ? BauhausDesign.surfaceLight
                      : BauhausDesign.neutral,
                  borderRadius: BorderRadius.circular(
                    2.0,
                  ), // Sharp square thumb
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
