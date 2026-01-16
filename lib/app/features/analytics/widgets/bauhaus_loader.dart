import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/bauhaus_theme.dart';

class BauhausLoader extends StatelessWidget {
  final double size;
  final Color color;

  const BauhausLoader({
    super.key,
    this.size = 40,
    this.color = BauhausTheme.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: BauhausTheme.black, width: 2),
        ),
      )
      .animate(onPlay: (controller) => controller.repeat())
      .rotate(duration: 1200.ms, curve: Curves.easeInOutBack)
      .scale(
        begin: const Offset(0.8, 0.8),
        end: const Offset(1.0, 1.0),
        duration: 600.ms,
        curve: Curves.easeInOut,
      )
      .then()
      .scale(
        begin: const Offset(1.0, 1.0),
        end: const Offset(0.8, 0.8),
        duration: 600.ms,
        curve: Curves.easeInOut,
      ),
    );
  }
}
