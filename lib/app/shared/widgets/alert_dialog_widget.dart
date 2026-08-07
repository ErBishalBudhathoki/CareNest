import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

Future<void> showAlertDialog(
  BuildContext context, {
  String message = "Checking details...",
  bool showProgress = true,
}) {
  return showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black54,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Container(
            width: 280,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 3.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
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
                      color: BauhausDesign.primary,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2.0,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please wait...",
                  textAlign: TextAlign.center,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
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
    barrierColor: Colors.black54,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 3.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
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
                  color: BauhausDesign.primary,
                  border: Border.all(color: BauhausDesign.neutral, width: 2.0),
                ),
                child: const Icon(
                  Icons.help_outline,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
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
                          color: BauhausDesign.surfaceWhite,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          cancelText,
                          textAlign: TextAlign.center,
                          style: BauhausDesign.getTextTheme(context).bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.textDark,
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
                          color: confirmColor ?? BauhausDesign.primary,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 2.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
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
                                color: Colors.white,
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
