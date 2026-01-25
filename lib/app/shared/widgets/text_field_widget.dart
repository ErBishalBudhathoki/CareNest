import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

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
          obscureText: isObscure,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          style: BauhausDesign.getTextTheme(context).bodyLarge,
          decoration: BauhausDesign.inputDecoration(hintText).copyWith(
            prefixIcon: prefixIcon ?? (prefixIconData != null ? Icon(prefixIconData, color: BauhausDesign.textMuted) : null),
            suffixIcon: suffixIconClickable
                ? IconButton(
                    icon: Icon(
                      getSuffixIcon != null 
                          ? getSuffixIcon!(isObscure) 
                          : (isObscure ? Icons.visibility_off : Icons.visibility),
                      color: BauhausDesign.textMuted,
                    ),
                    onPressed: () {
                      obscureTextNotifier.value = !obscureTextNotifier.value;
                    },
                  )
                : (suffixIcon ?? (suffixIconData != null ? Icon(suffixIconData, color: BauhausDesign.textMuted) : null)),
          ),
        );
      },
    );
  }
}
