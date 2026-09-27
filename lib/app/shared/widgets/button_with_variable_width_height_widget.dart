import 'package:flutter/material.dart';

class ButtonWithVariableWH extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final double height;
  final double width;
  final VoidCallback onPressed;

  const ButtonWithVariableWH({
    super.key,
    required this.title,
    required this.hasBorder,
    required this.onPressed,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: hasBorder ? colorScheme.surface : colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(color: colorScheme.primary, width: 1.0)
              : const Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style:
                    const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ).copyWith(
                      color: hasBorder
                          ? colorScheme.primary
                          : colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
