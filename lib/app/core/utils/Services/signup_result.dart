

import 'package:flutter/material.dart';

class SignupResult {
  final bool success;
  final String title;
  final String message;
  final Color surfaceColor;

  SignupResult({
    required this.success,
    required this.title,
    required this.message,
    required this.surfaceColor,
  });
}
