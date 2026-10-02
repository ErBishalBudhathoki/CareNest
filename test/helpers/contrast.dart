import 'dart:math' as math;

import 'package:flutter/material.dart';

/// WCAG 2.1 relative luminance contrast ratio between two opaque colours.
///
/// Lives here rather than in one test file because the check keeps getting
/// re-derived per feature: `requests_appbar_test.dart` had a private copy, and
/// duplicating it is how a colour regression slips past a second suite.
double contrastRatio(Color a, Color b) {
  double lum(Color c) {
    double f(double v) =>
        v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4) as double;
    return 0.2126 * f(c.r) + 0.7152 * f(c.g) + 0.0722 * f(c.b);
  }

  final l1 = lum(a), l2 = lum(b);
  final hi = l1 > l2 ? l1 : l2;
  final lo = l1 > l2 ? l2 : l1;
  return (hi + 0.05) / (lo + 0.05);
}

/// [contrastRatio] rounded to two decimals, for readable failure messages.
String contrast(Color a, Color b) => contrastRatio(a, b).toStringAsFixed(2);
