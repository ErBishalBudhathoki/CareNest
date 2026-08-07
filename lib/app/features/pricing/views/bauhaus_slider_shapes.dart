import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BauhausSliderThumbShape extends SliderComponentShape {
  final double thumbSize;

  const BauhausSliderThumbShape({this.thumbSize = 20.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbSize, thumbSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Draw square thumb
    final Paint fillPaint = Paint()
      ..color = BauhausDesign
          .accent // Yellow/Accent color
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = BauhausDesign.neutral
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: thumbSize,
      height: thumbSize,
    );

    // Add hard shadow for the thumb
    final Path shadowPath = Path()..addRect(thumbRect.translate(2, 2));
    canvas.drawPath(shadowPath, Paint()..color = BauhausDesign.neutral);

    canvas.drawRect(thumbRect, fillPaint);
    canvas.drawRect(thumbRect, borderPaint);
  }
}

class BauhausSliderTrackShape extends SliderTrackShape {
  const BauhausSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = 32.0; // Height of the outer box
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
  }) {
    final Canvas canvas = context.canvas;
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // 1. Draw Outer Box (White background, Black border)
    final Paint boxFill = Paint()..color = BauhausDesign.surfaceLight;
    final Paint boxBorder = Paint()
      ..color = BauhausDesign.neutral
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(trackRect, boxFill);
    canvas.drawRect(trackRect, boxBorder);

    // 2. Draw Inner Gradient Line
    // The line should be centered in the box
    final double innerLineHeight = 4.0;
    final double innerLineTop = trackRect.center.dy - (innerLineHeight / 2);
    final Rect innerLineRect = Rect.fromLTWH(
      trackRect.left + 8, // Padding
      innerLineTop,
      trackRect.width - 16, // Padding
      innerLineHeight,
    );

    final Paint linePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          BauhausDesign.secondary, // Blue
          BauhausDesign.primary, // Red
          BauhausDesign.accent, // Yellow
        ],
      ).createShader(innerLineRect);

    canvas.drawRect(innerLineRect, linePaint);
  }
}
