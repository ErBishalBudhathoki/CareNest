import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

enum AppSnackType { success, error, info, warning }

/// Shows a consistent, Bauhaus-styled snackbar with readable (non-grey)
/// colours. Use this for all user-facing feedback instead of raw SnackBars.
///
/// Contrast mapping (background -> foreground):
/// - success (green), error (red), info (indigo): white text/icons
/// - warning (yellow): dark text/icons — white on yellow is unreadable.
void showAppSnackBar(
  BuildContext context,
  String message, {
  AppSnackType type = AppSnackType.info,
  Duration duration = const Duration(seconds: 3),
  String? actionLabel,
  VoidCallback? onAction,
}) {
  final Color background = switch (type) {
    AppSnackType.success => BauhausDesign.success,
    AppSnackType.error => BauhausDesign.error,
    AppSnackType.info => BauhausDesign.secondary,
    AppSnackType.warning => BauhausDesign.warning,
  };
  // Warning yellow needs dark foreground for readability; the saturated
  // red/green/blue backgrounds keep white foreground.
  final Color foreground = switch (type) {
    AppSnackType.warning => BauhausDesign.textDark,
    AppSnackType.success ||
    AppSnackType.error ||
    AppSnackType.info => BauhausDesign.surfaceWhite,
  };
  final IconData icon = switch (type) {
    AppSnackType.success => Icons.check_circle_outline,
    AppSnackType.error => Icons.error_outline,
    AppSnackType.info => Icons.info_outline,
    AppSnackType.warning => Icons.hourglass_top_outlined,
  };

  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      backgroundColor: background,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: foreground,
              onPressed: onAction ?? () {},
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      content: Semantics(
        liveRegion: true,
        label: message,
        child: Row(
          children: [
            Icon(icon, color: foreground, size: 20),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                message,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
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

void showWarningSnack(BuildContext context, String message) =>
    showAppSnackBar(context, message, type: AppSnackType.warning);
