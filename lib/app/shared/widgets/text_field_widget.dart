import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, isObscure, child) {
        return TextFormField(
          controller: controller,
          obscureText: isObscure,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon ?? (prefixIconData != null ? Icon(prefixIconData) : null),
            suffixIcon: suffixIconClickable
                ? IconButton(
                    icon: Icon(
                      getSuffixIcon != null 
                          ? getSuffixIcon!(isObscure) 
                          : (isObscure ? Icons.visibility_off : Icons.visibility),
                    ),
                    onPressed: () {
                      obscureTextNotifier.value = !obscureTextNotifier.value;
                    },
                  )
                : (suffixIcon ?? (suffixIconData != null ? Icon(suffixIconData) : null)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        );
      },
    );
  }
}
