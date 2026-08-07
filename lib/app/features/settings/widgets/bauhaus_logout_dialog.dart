import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:google_fonts/google_fonts.dart';

class BauhausLogoutDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const BauhausLogoutDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final headerForeground =
        ThemeData.estimateBrightnessForColor(BauhausDesign.error) ==
            Brightness.dark
        ? BauhausDesign.textLight
        : BauhausDesign.textDark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border.all(
            color: BauhausDesign.textDark, // Use textDark for black branding
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: BauhausDesign.textDark, // Hard black shadow
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Strip
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: BauhausDesign.error, // Red header for destructive action
                border: Border(
                  bottom: BorderSide(color: BauhausDesign.textDark, width: 3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: headerForeground,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: headerForeground,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Body
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: BauhausDesign.getTextTheme(context).bodyLarge
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontSize: 16,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onCancel?.call();
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape:
                                const RoundedRectangleBorder(), // Square corners
                            side: BorderSide(
                              color: BauhausDesign.textDark,
                              width: 2,
                            ),
                            backgroundColor: Colors.transparent,
                            foregroundColor: BauhausDesign.textDark,
                          ),
                          child: Text(
                            cancelText.toUpperCase(),
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: BauhausDesign.textDark,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Logout Button
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onConfirm();
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape:
                                const RoundedRectangleBorder(), // Square corners
                            backgroundColor:
                                BauhausDesign.textDark, // Solid black button
                            foregroundColor: BauhausDesign.surfaceLight,
                            elevation: 0,
                          ),
                          child: Text(
                            confirmText.toUpperCase(),
                            style: GoogleFonts.oswald(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: BauhausDesign.surfaceLight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
