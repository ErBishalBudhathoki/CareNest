import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BauhausContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const BauhausContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.color,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(BauhausDesign.space4),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        borderRadius: BorderRadius.zero,
      ),
      child: child,
    );
  }
}
