
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});
  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Draw animated blob/gradient shapes
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return CustomPaint(
          painter: _GradientBlobPainter(t),
          child: Container(),
        );
      },
    );
  }
}

class _GradientBlobPainter extends CustomPainter {
  final double t;
  _GradientBlobPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width == 0 ? 430.0 : size.width;
    final h = size.height == 0 ? 900.0 : size.height;
    // Main purple gradient surface
    final rect = Rect.fromLTWH(0, 0, w, h);
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color.lerp(const Color(0xFF7628F8), const Color(0xFFB381FC),
              .5 + .5 * sin(t * 2 * pi))!,
          Color.lerp(const Color(0xFF9034e5), const Color(0xFF30C1E8),
              .5 + .5 * cos(t * 2 * pi))!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, paint);

    // Animated blob at top-right
    final blobRadius = 140.0 + 15 * sin(t * 2 * pi);
    final blobCenter =
        Offset(w - 90 + 20 * cos(t * pi), 110 + 10 * sin(t * pi));
    final blobPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF7B64FD).withOpacity(0.1),
          Colors.transparent
        ],
        radius: 1,
      ).createShader(Rect.fromCircle(center: blobCenter, radius: blobRadius));
    canvas.drawCircle(blobCenter, blobRadius, blobPaint);

    // Bottom white shape as custom path
    final path = Path()
      ..moveTo(0, h * 0.17 + 24 * sin(t * pi))
      ..quadraticBezierTo(
          w * 0.25, h * 0.13 + 12 * cos(t * pi), w * 0.5, h * 0.19)
      ..quadraticBezierTo(w * 0.75, h * 0.25 - 18 * sin(t * pi), w, h * 0.16)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final bottomPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.grey[100]!.withOpacity(0.1)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawPath(path, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
