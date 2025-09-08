import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldWidget extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueNotifier<bool> obscureTextNotifier;
  final bool suffixIconClickable;
  final Function(String) onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final IconData Function(bool isVisible)? getSuffixIcon;
  final bool? confirmPasswordToggle;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureTextNotifier,
    required this.suffixIconClickable,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    this.prefixIconData,
    this.suffixIconData,
    this.prefixIcon,
    this.suffixIcon,
    this.getSuffixIcon,
    this.confirmPasswordToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, isObscure, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          obscureText: isObscure,
          cursorColor: ModernSaasDesign.primary,
          style: ModernSaasDesign.bodyLarge.copyWith(
            color: ModernSaasDesign.primary,
          ),
          decoration: InputDecoration(
            fillColor: ModernSaasDesign.surface, // Set background color
            filled: true,
            hintText: hintText, // Use hintText instead of labelText
            hintStyle: TextStyle(
              color: ModernSaasDesign.primary
                  .withValues(alpha: 0.6), // Hint text color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ModernSaasDesign.primary,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ModernSaasDesign.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              // Define errorBorder
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ModernSaasDesign.error, // Red border for errors
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              // Define focusedErrorBorder
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ModernSaasDesign.error, // Red border for focused errors
                width: 2.0,
              ),
            ),
            errorStyle: ModernSaasDesign.bodySmall.copyWith(
              color: ModernSaasDesign.error,
            ),
            prefixIcon: prefixIcon ??
                (prefixIconData != null
                    ? Icon(
                        prefixIconData,
                        size: 18,
                        color: ModernSaasDesign.primary,
                      )
                    : null),
            suffixIcon: suffixIcon ??
                (suffixIconClickable
                    ? IconButton(
                        onPressed: () {
                          obscureTextNotifier.value =
                              !obscureTextNotifier.value;
                        },
                        icon: Icon(
                          getSuffixIcon?.call(isObscure) ?? suffixIconData,
                          size: 18,
                          color: ModernSaasDesign.primary,
                        ),
                      )
                    : null),
          ),
        );
      },
    );
  }
}
