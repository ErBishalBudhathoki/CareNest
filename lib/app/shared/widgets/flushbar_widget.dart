import 'package:another_flushbar/flushbar.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';

class FlushBarWidget {
  Flushbar flushBar({
    required BuildContext context,
    required String title,
    required String message,
    // required IconData icon,
    required Color backgroundColor,
    IconData icon = Icons.info_outline,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      icon: Icon(icon, color: BauhausDesign.surfaceWhite, size: 24),
      backgroundColor: backgroundColor,
      duration: duration,
      borderColor: BauhausDesign.neutral,
      borderWidth: 2,
      message: message,
      messageSize: 14,
      mainButton: actionLabel != null
          ? TextButton(
              onPressed: onAction,
              child: Text(
                actionLabel,
                style: const TextStyle(
                  color: BauhausDesign.surfaceWhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : null,
      titleText: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    )..show(context);
  }
}
