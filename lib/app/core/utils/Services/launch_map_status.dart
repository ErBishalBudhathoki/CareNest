import 'package:flutter/material.dart';


class LaunchMapStatus {
  final bool success;
  final String title;
  final String message;
  final Color surfaceColor;

  LaunchMapStatus({
    required this.success,
    required this.title,
    required this.message,
    required this.surfaceColor,
  });
}
