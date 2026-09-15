import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

enum AppSnackType { success, error, info }

/// Shows a consistent, Bauhaus-styled snackbar with readable (non-grey)
/// colours. Use this for all user-facing feedback instead of raw SnackBars.
void showAppSnackBar(
  BuildContext context,
  String message, {
  AppSnackType type = AppSnackType.info,
}) {
  final Color background = switch (type) {
    AppSnackType.success => BauhausDesign.success,
    AppSnackType.error => BauhausDesign.error,
    AppSnackType.info => BauhausDesign.secondary,
  };
  final IconData icon = switch (type) {
    AppSnackType.success => Icons.check_circle_outline,
    AppSnackType.error => Icons.error_outline,
    AppSnackType.info => Icons.info_outline,
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: background,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      content: Row(
        children: [
          Icon(icon, color: BauhausDesign.surfaceWhite, size: 20),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Text(
              message,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuccessSnack(BuildContext context, String message) =>
    showAppSnackBar(context, message, type: AppSnackType.success);

void showErrorSnack(BuildContext context, String message) =>
    showAppSnackBar(context, message, type: AppSnackType.error);

void showInfoSnack(BuildContext context, String message) =>
    showAppSnackBar(context, message, type: AppSnackType.info);
