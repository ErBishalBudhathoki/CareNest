import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = buttonColor ?? BauhausDesign.primary;
    final effectiveTextColor = textColor ?? BauhausDesign.surfaceWhite;
    final isDisabled = onPressed == null;

    return Container(
      decoration: BoxDecoration(
        color: isDisabled
            ? BauhausDesign.surfaceOffWhite
            : effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        boxShadow: isDisabled ? [] : [BauhausDesign.shadowHard],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          child: Container(
            constraints: const BoxConstraints(minHeight: 44),
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space6,
              vertical: BauhausDesign.space3,
            ),
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        effectiveTextColor,
                      ),
                    ),
                  )
                : Text(
                    buttonText,
                    style: GoogleFonts.inter(
                      color: isDisabled
                          ? BauhausDesign.textMuted
                          : effectiveTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }
}
