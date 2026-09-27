import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

Future<void> showAlertDialog(
  BuildContext context, {
  String message = "Checking details...",
  bool showProgress = true,
}) {
  return showDialog(
    barrierDismissible: false,
    barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.54),
    context: context,
    builder: (BuildContext context) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            width: 280,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border.all(color: colorScheme.outline, width: 3.0),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow,
                  offset: Offset(4, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showProgress) ...[
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      border: Border.all(
                        color: colorScheme.outline,
                        width: 2.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorScheme.onPrimary,
                        ),
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: BauhausDesign.getTextTheme(context).bodyLarge
                      ?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please wait...",
                  textAlign: TextAlign.center,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showBauhausConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmText = "Confirm",
  String cancelText = "Cancel",
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  Color? confirmColor,
}) {
  return showDialog(
    barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.54),
    context: context,
    builder: (BuildContext context) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final resolvedConfirmColor = confirmColor ?? colorScheme.primary;
      final confirmTextColor = BauhausDesign.readableOnColor(
        resolvedConfirmColor,
      );
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.outline, width: 3.0),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow,
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  border: Border.all(color: colorScheme.outline, width: 2.5),
                ),
                child: Icon(
                  Icons.help_outline,
                  color: colorScheme.onPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        onCancel?.call();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          border: Border.all(
                            color: colorScheme.outline,
                            width: 2.5,
                          ),
                        ),
                        child: Text(
                          cancelText,
                          textAlign: TextAlign.center,
                          style: BauhausDesign.getTextTheme(context).bodyMedium
                              ?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: resolvedConfirmColor,
                          border: Border.all(
                            color: colorScheme.outline,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow,
                              offset: Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          confirmText,
                          textAlign: TextAlign.center,
                          style: BauhausDesign.getTextTheme(context).bodyMedium
                              ?.copyWith(
                                color: confirmTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
