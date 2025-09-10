import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'clipper_Widget.dart';


class WaveAnimation extends StatefulWidget {
  final Size size;
  final Color color;
  final double yOffset;

  const WaveAnimation({
    super.key,
    required this.size,
    required this.color,
    required this.yOffset,
  });

  @override
  _WaveAnimationState createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with TickerProviderStateMixin {
  List<Offset> wavePoints = [];
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 12000)) // Much slower 12-second cycle
      ..addListener(() {
        wavePoints.clear();

        // Use a continuous time-based animation instead of value-based
        final double time = animationController.value * Math.pi * 2;
        double waveWidth = Math.pi / 240; // Lower frequency for gentler waves
        double waveHeight = 15.0; // Slightly reduced amplitude
        double waveSpeed = time * 15; // Much slower movement

        // Create smooth wave points with consistent amplitude
        for (int i = 0; i <= widget.size.width.toInt(); i += 2) {
          // Primary wave
          double primaryWave = Math.sin((i * waveWidth) + waveSpeed);
          // Secondary wave for complexity (offset phase)
          double secondaryWave = Math.sin((i * waveWidth * 1.3) + (waveSpeed * 0.7)) * 0.3;
          // Combine waves with consistent amplitude
          double combinedWave = primaryWave + secondaryWave;
          
          wavePoints.add(Offset(
              i.toDouble(), 
              combinedWave * waveHeight + widget.yOffset));
        }
        
        // Ensure we have the final point
        if (wavePoints.isNotEmpty && wavePoints.last.dx < widget.size.width) {
          double finalPrimary = Math.sin((widget.size.width * waveWidth) + waveSpeed);
          double finalSecondary = Math.sin((widget.size.width * waveWidth * 1.3) + (waveSpeed * 0.7)) * 0.3;
          double finalCombined = finalPrimary + finalSecondary;
          wavePoints.add(Offset(
              widget.size.width, 
              finalCombined * waveHeight + widget.yOffset));
        }
      });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return ClipPath(
          clipper: ClipperWidget(
            waveList: wavePoints,
          ),
          child: Container(
            height: widget.size.height,
            width: widget.size.width,
            color: widget.color,
          ),
        );
      },
    );
  }
}
