import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';

class BauhausLiquidAnimation extends StatefulWidget {
  final double height;
  final double yOffset;

  const BauhausLiquidAnimation({
    super.key,
    this.height = 200,
    this.yOffset = 20,
  });

  @override
  State<BauhausLiquidAnimation> createState() => _BauhausLiquidAnimationState();
}

class _BauhausLiquidAnimationState extends State<BauhausLiquidAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Original duration: 12000ms. Slowed down to 20000ms as requested.
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 20000))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _BauhausLiquidPainter(
              animationValue: _controller.value,
              primaryColor: BauhausDesign.secondary, // Yellow (back)
              secondaryColor: BauhausDesign.primary, // Red (front)
              yOffset: widget.yOffset,
            ),
          );
        },
      ),
    );
  }
}

class _BauhausLiquidPainter extends CustomPainter {
  final double animationValue;
  final Color primaryColor;
  final Color secondaryColor;
  final double yOffset;

  _BauhausLiquidPainter({
    required this.animationValue,
    required this.primaryColor,
    required this.secondaryColor,
    required this.yOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paints
    final paintFillBack = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    final paintFillFront = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;
      
    final paintStroke = Paint()
      ..color = BauhausDesign.neutral
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Time-based factor from original code: time = ctrl.value * 2 * pi
    final double time = animationValue * math.pi * 2;
    // waveWidth = pi / 240
    // waveHeight = 15.0
    // waveSpeed = time * 15
    final double waveWidth = math.pi / 240;
    final double waveHeight = 15.0;
    final double waveSpeed = time * 15;

    // --- Back Wave (Secondary) ---
    // In original: "Secondary wave... offset phase? ... 0.3 amplitude factor?"
    // Actually original code combined two sines into ONE wave.
    // "Combined wave = sin(...) + sin(...) * 0.3"
    // And it drew TWO such waves?
    // "WaveAnimation(..., yOffset: 40) ... Positioned(..., WaveAnimation(..., yOffset: 30))"
    // So there were TWO separate widgets stacked.
    // Here we will draw two paths in one painter for efficiency.

    // Path 1 (Back Wave): Matches the "lower" one (yOffset 40)
    // We'll give it a slightly different phase or speed to distinguish it.
    // Or just replicate the stacking logic by drawing two paths with offsets.
    
    // Wave 1 Param
    final pathBack = _createWavePath(
      size,
      waveWidth,
      waveHeight,
      waveSpeed,
      yOffset + 10, // Slightly lower
    );
    canvas.drawPath(pathBack, paintFillBack);
    canvas.drawPath(pathBack, paintStroke);

    // Wave 2 Param (Front)
    // We shift the phase or speed slightly to make them independent
    final pathFront = _createWavePath(
      size,
      waveWidth,
      waveHeight,
      waveSpeed + 1.5, // Phase shift
      yOffset, 
    );
    canvas.drawPath(pathFront, paintFillFront);
    canvas.drawPath(pathFront, paintStroke);
  }

  Path _createWavePath(
    Size size,
    double waveWidth,
    double waveHeight,
    double waveSpeed,
    double verticalShift,
  ) {
    final path = Path();
    // We want the wave to be at the TOP of the path, filling down to bottom.
    // Wait, original ClipperWidget filled:
    // path.addPolygon(points) ... lineTo(width, height) ... lineTo(0, height) ... close
    // Points were: (i, combinedWave * waveHeight + yOffset)
    // So y=0 is top. As y increases, we go down.
    // If yOffset is small (30), the wave is near the top of the container.
    
    // We need to generate points exactly like the loop.
    final List<Offset> points = [];
    for (double i = 0; i <= size.width; i += 2) {
      // Primary sine
      double primary = math.sin((i * waveWidth) + waveSpeed);
      // Secondary sine
      double secondary = math.sin((i * waveWidth * 1.3) + (waveSpeed * 0.7)) * 0.3;
      double combined = primary + secondary;
      
      points.add(Offset(i, combined * waveHeight + verticalShift));
    }

    // Ensure the final point at exactly size.width is added to close the gap
    // Recalculate for size.width to match the wave function perfectly
    double i = size.width;
    double primary = math.sin((i * waveWidth) + waveSpeed);
    double secondary = math.sin((i * waveWidth * 1.3) + (waveSpeed * 0.7)) * 0.3;
    double combined = primary + secondary;
    points.add(Offset(i, combined * waveHeight + verticalShift));

    path.addPolygon(points, false);
    path.lineTo(size.width, 0); // Top Right
    path.lineTo(0, 0); // Top Left
    path.close();
    
    return path;
  }

  @override
  bool shouldRepaint(covariant _BauhausLiquidPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
