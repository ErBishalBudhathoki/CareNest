

import 'package:flutter/material.dart';

class UploadNotes {
  final bool success;
  final String title;
  final String message;
  final Color surfaceColor;

  UploadNotes({
    required this.success,
    required this.title,
    required this.message,
    required this.surfaceColor,
  });
}
