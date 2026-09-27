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
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final ValueChanged<String>? onSubmitted;

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
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.focusNode,
    this.nextFocusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, isObscure, child) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: isObscure,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction:
              textInputAction ??
              (nextFocusNode != null
                  ? TextInputAction.next
                  : TextInputAction.done),
          autofillHints: autofillHints,
          onFieldSubmitted: (value) {
            onSubmitted?.call(value);
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            filled: theme.inputDecorationTheme.filled,
            fillColor: theme.inputDecorationTheme.fillColor,
            contentPadding: theme.inputDecorationTheme.contentPadding,
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.enabledBorder,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            errorBorder: theme.inputDecorationTheme.errorBorder,
            focusedErrorBorder: theme.inputDecorationTheme.focusedErrorBorder,
            hintStyle: theme.inputDecorationTheme.hintStyle,
            errorStyle: theme.inputDecorationTheme.errorStyle,
            hintText: hintText,
            prefixIcon:
                prefixIcon ??
                (prefixIconData != null
                    ? Icon(prefixIconData, color: colorScheme.onSurfaceVariant)
                    : null),
            suffixIcon: suffixIconClickable
                ? IconButton(
                    tooltip: isObscure ? 'Show password' : 'Hide password',
                    icon: Icon(
                      getSuffixIcon != null
                          ? getSuffixIcon!(isObscure)
                          : (isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                      color: colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () {
                      obscureTextNotifier.value = !obscureTextNotifier.value;
                    },
                  )
                : (suffixIcon ??
                      (suffixIconData != null
                          ? Icon(
                              suffixIconData,
                              color: colorScheme.onSurfaceVariant,
                            )
                          : null)),
          ),
        );
      },
    );
  }
}
