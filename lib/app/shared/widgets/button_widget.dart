import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color buttonColor;
  final Color textColor;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor = ModernSaasDesign.primary,
    this.textColor = ModernSaasDesign.textOnPrimary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: buttonColor,
            width: 1.0,
          ),
        ),
        child: InkWell(
          onTap: isLoading ? null : onPressed, // Disable onTap when loading
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 60.0,
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 24, // Set a fixed size for the progress indicator
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth:
                            3, // Adjust the thickness of the progress bar
                        valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      ),
                    )
                  : Text(
                      buttonText,
                      style: ModernSaasDesign.labelLarge.copyWith(
                        color: textColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
