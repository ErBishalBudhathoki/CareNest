import 'package:another_flushbar/flushbar.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkBackground =
        ThemeData.estimateBrightnessForColor(backgroundColor) ==
        Brightness.dark;
    final foreground = isDarkBackground
        ? (theme.brightness == Brightness.dark
              ? colorScheme.onSurface
              : colorScheme.surface)
        : (theme.brightness == Brightness.dark
              ? colorScheme.onInverseSurface
              : colorScheme.onSurface);

    return Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      icon: Icon(icon, color: foreground, size: 24),
      backgroundColor: backgroundColor,
      duration: duration,
      borderColor: colorScheme.outline,
      borderWidth: 2,
      message: message,
      messageSize: 14,
      mainButton: actionLabel != null
          ? TextButton(
              onPressed: onAction,
              child: Text(
                actionLabel,
                style: TextStyle(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : null,
      titleText: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: foreground,
        ),
      ),
    )..show(context);
  }
}
