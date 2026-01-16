import 'package:flutter/material.dart';
import '../theme/bauhaus_theme.dart';

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
      padding: padding ?? BauhausTheme.blockPadding,
      margin: margin,
      decoration: BauhausTheme.blockDecoration.copyWith(
        color: color ?? BauhausTheme.white,
      ),
      child: child,
    );
  }
}
