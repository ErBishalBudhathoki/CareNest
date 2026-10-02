import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ==================== ENUMS ====================

enum BauhausChipVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  outlined,
  neutral,
}

enum BauhausActionVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  ghost,
  danger,
  neutral,
}

enum BauhausChipSize { small, medium, large }

// ==================== CARDS ====================

class BauhausCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;

  const BauhausCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(BauhausDesign.space4),
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget card = Container(
      margin: margin,
      padding: padding,
      decoration: BauhausDesign.cardDecorationFor(context).copyWith(
        color: backgroundColor ?? colorScheme.surfaceContainerLow,
        border: Border.all(
          color: borderColor ?? colorScheme.outline,
          width: 2.5,
        ),
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.zero,
          child: card,
        ),
      );
    }

    return card;
  }
}

class BauhausStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor; // Replaces gradientColors
  final double? changePercentage;
  final VoidCallback? onTap;
  final bool isLoading;

  const BauhausStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
    this.iconColor,
    this.changePercentage,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPositiveChange = changePercentage != null && changePercentage! > 0;
    final changeColor = isPositiveChange
        ? colorScheme.secondary
        : colorScheme.primary;

    return BauhausCard(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxHeight < 110;
          final titleStyle = BauhausDesign.getTextTheme(
            context,
          ).bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant);
          final subtitleStyle = BauhausDesign.getTextTheme(context).bodyMedium
              ?.copyWith(color: colorScheme.onSurfaceVariant, fontSize: 12);

          if (isCompact) {
            final valueStyle =
                BauhausDesign.getTextTheme(context).titleLarge ??
                const TextStyle(fontSize: 18);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space1),
                      decoration: BoxDecoration(
                        color: (iconColor ?? colorScheme.primary).withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.zero,
                        border: Border.all(
                          color: colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ?? colorScheme.primary,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: isLoading
                          ? Container(
                              height: 18,
                              color: colorScheme.outline.withValues(alpha: 0.1),
                            )
                          : FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                value,
                                style: valueStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle,
                ),
              ],
            );
          }

          final valueStyle = BauhausDesign.getTextTheme(context).displayMedium;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space2),
                    decoration: BoxDecoration(
                      color: (iconColor ?? colorScheme.primary).withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: colorScheme.outline, width: 1),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  if (changePercentage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: changeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.zero,
                        border: Border.all(
                          color: colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPositiveChange
                                ? Icons.trending_up
                                : Icons.trending_down,
                            color: changeColor,
                            size: 12,
                          ),
                          const SizedBox(width: BauhausDesign.space1),
                          Text(
                            '${changePercentage!.abs().toStringAsFixed(1)}%',
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).labelSmall?.copyWith(color: changeColor),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space4),
              if (isLoading)
                Container(
                  height: 24,
                  width: 80,
                  color: colorScheme.outline.withValues(alpha: 0.1),
                )
              else
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: valueStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const SizedBox(height: BauhausDesign.space1),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: titleStyle,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: subtitleStyle,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

// ==================== INPUTS & CONTROLS ====================

class BauhausCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;

  const BauhausCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Theme(
      data: theme.copyWith(
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.surfaceContainerHighest;
            }
            if (states.contains(WidgetState.selected)) {
              return activeColor ?? colorScheme.primary;
            }
            return colorScheme.surface;
          }),
          checkColor: WidgetStateProperty.all(
            checkColor ??
                (value ? colorScheme.onPrimary : colorScheme.onSurface),
          ),
          side: BorderSide(color: colorScheme.outline, width: 2),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
      child: Checkbox(value: value, onChanged: onChanged),
    );
  }
}

class BauhausChip extends StatelessWidget {
  final String? label;
  final String? text; // Alias for label for backward compatibility
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? color;
  final BauhausChipVariant variant;
  final BauhausChipSize size;
  final bool isSmall; // Shorthand for size: BauhausChipSize.small

  const BauhausChip({
    super.key,
    this.label,
    this.text,
    this.isSelected = false,
    this.onTap,
    this.icon,
    this.color,
    this.variant = BauhausChipVariant.primary,
    this.size = BauhausChipSize.medium,
    this.isSmall = false,
  }) : assert(
         label != null || text != null,
         'Either label or text must be provided',
       );

  String get _effectiveLabel => label ?? text ?? '';

  BauhausChipSize get _effectiveSize => isSmall ? BauhausChipSize.small : size;

  EdgeInsets get _padding {
    switch (_effectiveSize) {
      case BauhausChipSize.small:
        return const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space2,
          vertical: BauhausDesign.space1,
        );
      case BauhausChipSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space2,
        );
      case BauhausChipSize.large:
        return const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space6,
          vertical: BauhausDesign.space3,
        );
    }
  }

  double get _iconSize {
    switch (_effectiveSize) {
      case BauhausChipSize.small:
        return 12;
      case BauhausChipSize.medium:
        return 16;
      case BauhausChipSize.large:
        return 20;
    }
  }

  double get _fontSize {
    switch (_effectiveSize) {
      case BauhausChipSize.small:
        return 10;
      case BauhausChipSize.medium:
        return 12;
      case BauhausChipSize.large:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color effectiveColor = color ?? colorScheme.primary;
    Color textColor = colorScheme.onPrimary;

    if (color == null) {
      switch (variant) {
        case BauhausChipVariant.primary:
          effectiveColor = colorScheme.primary;
          textColor = colorScheme.onPrimary;
          break;
        case BauhausChipVariant.secondary:
          effectiveColor = colorScheme.secondary;
          textColor = colorScheme.onSecondary;
          break;
        case BauhausChipVariant.success:
          effectiveColor = colorScheme.secondary;
          textColor = colorScheme.onSecondary;
          break;
        case BauhausChipVariant.warning:
          effectiveColor = colorScheme.primary;
          textColor = colorScheme.onPrimary;
          break;
        case BauhausChipVariant.error:
          effectiveColor = colorScheme.tertiary;
          textColor = colorScheme.onTertiary;
          break;
        case BauhausChipVariant.info:
          effectiveColor = colorScheme.secondary;
          textColor = colorScheme.onSecondary;
          break;
        case BauhausChipVariant.outlined:
          effectiveColor = colorScheme.surface;
          textColor = colorScheme.onSurface;
          break;
        case BauhausChipVariant.neutral:
          effectiveColor = colorScheme.inverseSurface;
          textColor = colorScheme.onInverseSurface;
          break;
      }
    }

    if (isSelected) {
      if (variant == BauhausChipVariant.outlined) {
        effectiveColor = colorScheme.primary;
        textColor = colorScheme.onPrimary;
      }
    }

    return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: _padding,
            decoration: BauhausDesign.chipDecorationFor(
              context,
              selected:
                  isSelected ||
                  (onTap == null && variant != BauhausChipVariant.outlined),
              color: effectiveColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 16,
                    color:
                        (isSelected ||
                            (onTap == null &&
                                variant != BauhausChipVariant.outlined))
                        ? textColor
                        : colorScheme.onSurface,
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                ],
                Flexible(
                  child: Text(
                    _effectiveLabel,
                    style: BauhausDesign.getTextTheme(context).labelLarge
                        ?.copyWith(
                          fontSize: _fontSize,
                          color:
                              (isSelected ||
                                  (onTap == null &&
                                      variant != BauhausChipVariant.outlined))
                              ? textColor
                              : colorScheme.onSurface,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(target: isSelected ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05));
  }
}

class BauhausSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onClear;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onFilterTap;

  const BauhausSearchBar({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.onClear,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              return TextField(
                controller: controller,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                textInputAction: TextInputAction.search,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  filled: theme.inputDecorationTheme.filled,
                  fillColor: theme.inputDecorationTheme.fillColor,
                  contentPadding: theme.inputDecorationTheme.contentPadding,
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.enabledBorder,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  errorBorder: theme.inputDecorationTheme.errorBorder,
                  focusedErrorBorder:
                      theme.inputDecorationTheme.focusedErrorBorder,
                  hintStyle: theme.inputDecorationTheme.hintStyle,
                  errorStyle: theme.inputDecorationTheme.errorStyle,
                  hintText: hintText,
                  prefixIcon:
                      prefixIcon ??
                      Icon(
                        Icons.search,
                        color: colorScheme.onSurfaceVariant,
                        semanticLabel: 'Search',
                      ),
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          tooltip: AppLocalizations.of(context)!.clearSearch,
                          icon: Icon(
                            Icons.clear,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          onPressed: () {
                            controller.clear();
                            onClear?.call();
                            onChanged?.call('');
                          },
                        )
                      : suffixIcon,
                ),
              );
            },
          ),
        ),
        if (onFilterTap != null) ...[
          const SizedBox(width: BauhausDesign.space3),
          BauhausActionButton(
            onPressed: onFilterTap,
            icon: Icons.tune,
            variant: BauhausActionVariant.secondary,
          ),
        ],
      ],
    );
  }
}

class BauhausTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int? maxLines;
  final bool enabled;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  const BauhausTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BauhausDesign.space1),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          maxLines: maxLines,
          enabled: enabled,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          style: theme.textTheme.bodyMedium,
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
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabled: enabled,
          ),
        ),
      ],
    );
  }
}

// ==================== BUTTONS ====================

class BauhausActionButton extends StatelessWidget {
  final String? text;
  final String? semanticsLabel;
  final String? tooltip;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final bool isOutlined;
  final bool isFullWidth;
  final bool isSmall;
  final BauhausActionVariant variant;

  const BauhausActionButton({
    super.key,
    this.text,
    this.semanticsLabel,
    this.tooltip,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
    this.isOutlined = false,
    this.isFullWidth = false,
    this.isSmall = false,
    this.variant = BauhausActionVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color effectiveBg = backgroundColor ?? colorScheme.primary;
    Color effectiveText = textColor ?? colorScheme.onPrimary;

    if (backgroundColor == null) {
      switch (variant) {
        case BauhausActionVariant.primary:
          effectiveBg = colorScheme.primary;
          effectiveText = colorScheme.onPrimary;
          break;
        case BauhausActionVariant.secondary:
          effectiveBg = colorScheme.surface;
          effectiveText = colorScheme.primary;
          break;
        case BauhausActionVariant.success:
          effectiveBg = colorScheme.secondary;
          effectiveText = colorScheme.onSecondary;
          break;
        case BauhausActionVariant.warning:
          effectiveBg = colorScheme.primary;
          effectiveText = colorScheme.onPrimary;
          break;
        case BauhausActionVariant.error:
        case BauhausActionVariant.danger:
          effectiveBg = colorScheme.tertiary;
          effectiveText = colorScheme.onTertiary;
          break;
        case BauhausActionVariant.info:
          effectiveBg = colorScheme.secondary;
          effectiveText = colorScheme.onSecondary;
          break;
        case BauhausActionVariant.ghost:
          effectiveBg = Colors.transparent;
          effectiveText = colorScheme.onSurface;
          break;
        case BauhausActionVariant.neutral:
          effectiveBg = colorScheme.surface;
          effectiveText = colorScheme.onSurface;
          break;
      }
    }

    if (isOutlined) {
      effectiveBg = colorScheme.surface;
      // Outlined means a surface background with an accent-coloured border and
      // label. Forcing primary here threw away the variant's own accent, so a
      // neutral outlined button painted hazard yellow on a near-white surface at
      // 1.57:1. Neutral is exempt: it exists to mean "no accent", and that is
      // exactly what the cancel buttons rely on.
      //
      // The other variants keep the yellow, so nothing else changes appearance.
      if (variant != BauhausActionVariant.neutral) {
        effectiveText = textColor ?? colorScheme.primary;
      }
    }

    // Ghost variant special handling
    if (variant == BauhausActionVariant.ghost) {
      final button = TextButton(
        onPressed: isLoading ? null : onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(effectiveText),
                ),
              )
            else if (icon != null)
              Icon(icon, color: effectiveText, size: 18),
            if ((icon != null || isLoading) && text != null)
              const SizedBox(width: BauhausDesign.space2),
            if (text != null)
              Text(
                text!,
                style: BauhausDesign.getTextTheme(
                  context,
                ).labelLarge?.copyWith(color: effectiveText),
              ),
          ],
        ),
      );
      return _wrapWithSemantics(button);
    }

    final button = Container(
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: BorderRadius.zero,
        border: Border.all(
          color: isOutlined ? effectiveText : colorScheme.outline,
          width: 2.5,
        ),
        boxShadow: isOutlined ? const [] : const [BauhausDesign.shadowHard],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? BauhausDesign.space3 : BauhausDesign.space6,
              vertical: isSmall ? BauhausDesign.space2 : BauhausDesign.space3,
            ),
            child: Row(
              mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(effectiveText),
                    ),
                  )
                else if (icon != null)
                  Icon(icon, color: effectiveText, size: 18),
                if ((icon != null || isLoading) && text != null)
                  const SizedBox(width: BauhausDesign.space2),
                if (text != null)
                  Flexible(
                    child: Text(
                      text!,
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).labelLarge?.copyWith(color: effectiveText),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    return _wrapWithSemantics(button);
  }

  Widget _wrapWithSemantics(Widget child) {
    Widget current = child;
    final tooltipMessage = tooltip?.trim();
    if (tooltipMessage != null && tooltipMessage.isNotEmpty) {
      current = Tooltip(message: tooltipMessage, child: current);
    }
    final label = semanticsLabel ?? text ?? tooltipMessage;
    if (label == null || label.isEmpty) {
      return current;
    }

    return Semantics(
      button: true,
      enabled: onPressed != null && !isLoading,
      label: label,
      excludeSemantics: true,
      child: current,
    );
  }
}

class BauhausIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final BauhausActionVariant variant;
  final bool isSmall;
  final String? tooltip;

  const BauhausIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.variant = BauhausActionVariant.neutral,
    this.isSmall = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color effectiveBg;
    Color effectiveIconColor;
    Color effectiveBorderColor = colorScheme.outline;

    switch (variant) {
      case BauhausActionVariant.primary:
        effectiveBg = colorScheme.primary;
        effectiveIconColor = colorScheme.onPrimary;
        effectiveBorderColor = colorScheme.primary;
        break;
      case BauhausActionVariant.secondary:
        effectiveBg = colorScheme.secondary;
        effectiveIconColor = colorScheme.onSecondary;
        effectiveBorderColor = colorScheme.secondary;
        break;
      case BauhausActionVariant.neutral:
        effectiveBg = colorScheme.surface;
        effectiveIconColor = colorScheme.onSurface;
        effectiveBorderColor = colorScheme.outline;
        break;
      case BauhausActionVariant.ghost:
        effectiveBg = Colors.transparent;
        effectiveIconColor = colorScheme.onSurface;
        effectiveBorderColor = Colors.transparent;
        break;
      default:
        effectiveBg = colorScheme.surface;
        effectiveIconColor = colorScheme.onSurface;
        effectiveBorderColor = colorScheme.outline;
    }

    Widget button = Semantics(
      button: true,
      enabled: onPressed != null,
      label: tooltip ?? icon.toString(),
      child:
          Container(
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                width: isSmall ? 48 : 48,
                height: isSmall ? 48 : 48,
                decoration: BoxDecoration(
                  color: effectiveBg,
                  borderRadius: BorderRadius.zero,
                  border: variant != BauhausActionVariant.ghost
                      ? Border.all(color: effectiveBorderColor, width: 2.5)
                      : null,
                  boxShadow: variant != BauhausActionVariant.ghost
                      ? const [BauhausDesign.shadowHardSm]
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    borderRadius: BorderRadius.zero,
                    child: Center(
                      child: Icon(
                        icon,
                        color: effectiveIconColor,
                        size: isSmall ? 18 : 22,
                        semanticLabel: tooltip,
                      ),
                    ),
                  ),
                ),
              )
              .animate(target: onPressed != null ? 1 : 0)
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(0.95, 0.95),
                duration: 100.ms,
              ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

class BauhausEmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final String? subtitle; // Alias for message for backward compatibility
  final IconData icon;
  final Widget? action;
  final VoidCallback? onAction;
  final String? actionLabel;

  const BauhausEmptyState({
    super.key,
    required this.title,
    this.message,
    this.subtitle,
    this.icon = Icons.inbox,
    this.action,
    this.onAction,
    this.actionLabel,
  }) : assert(
         message != null || subtitle != null,
         'Either message or subtitle must be provided',
       );

  String get _effectiveMessage => message ?? subtitle ?? '';

  Widget? get _effectiveAction {
    if (action != null) return action;
    if (onAction != null && actionLabel != null) {
      return BauhausActionButton(
        text: actionLabel,
        onPressed: onAction,
        variant: BauhausActionVariant.primary,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                border: Border.all(color: colorScheme.outline, width: 2.5),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Icon(icon, size: 48, color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: BauhausDesign.space6),
            Text(
              title,
              style: BauhausDesign.getTextTheme(
                context,
              ).headlineMedium?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              _effectiveMessage,
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            if (_effectiveAction != null) ...[
              const SizedBox(height: BauhausDesign.space6),
              _effectiveAction!,
            ],
          ],
        ),
      ),
    );
  }
}

class BauhausActionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget icon;
  final VoidCallback? onTap;
  final Color? color;
  final bool showChevron;

  const BauhausActionTile({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.color,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: BauhausCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space3,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(BauhausDesign.space2),
              decoration: BoxDecoration(
                color: (color ?? colorScheme.primary).withValues(alpha: 0.1),
                borderRadius: BorderRadius.zero,
                border: Border.all(color: colorScheme.outline, width: 1.5),
              ),
              alignment: Alignment.center,
              child: IconTheme(
                data: IconThemeData(
                  color: color ?? colorScheme.primary,
                  size: 24,
                ),
                child: icon,
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: BauhausDesign.getTextTheme(context).labelLarge
                        ?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: BauhausDesign.getTextTheme(context).bodySmall
                          ?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            if (showChevron) ...[
              const SizedBox(width: BauhausDesign.space2),
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space1),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: colorScheme.outline, width: 1.5),
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurface,
                  size: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==================== LAYOUT & STATUS ====================

class BauhausSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final EdgeInsetsGeometry? padding;

  const BauhausSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: BauhausDesign.getTextTheme(context).headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    subtitle!,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}

class BauhausErrorState extends StatelessWidget {
  final String title;
  final String? description;
  final String? message; // Alias for description for backward compatibility
  final VoidCallback? onRetry;
  final String retryText;

  const BauhausErrorState({
    super.key,
    this.title = 'Something went wrong',
    this.description,
    this.message,
    this.onRetry,
    this.retryText = 'Try Again',
  });

  String get _effectiveDescription =>
      description ??
      message ??
      'We encountered an error while loading your data.';

  @override
  Widget build(BuildContext context) {
    return BauhausEmptyState(
      icon: Icons.error_outline,
      title: title,
      message: _effectiveDescription,
      action: onRetry != null
          ? BauhausActionButton(
              text: retryText,
              onPressed: onRetry!,
              variant: BauhausActionVariant.secondary,
            )
          : null,
    );
  }
}

class BauhausLoadingState extends StatelessWidget {
  final String? message;
  final bool showMessage;

  const BauhausLoadingState({super.key, this.message, this.showMessage = true});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            strokeWidth: 3,
          ),
          if (showMessage) ...[
            const SizedBox(height: BauhausDesign.space4),
            Text(
              message ?? 'Loading...',
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class BauhausProgressIndicator extends StatelessWidget {
  final double value;
  final String? label;
  final Color? color;
  final double height;

  const BauhausProgressIndicator({
    super.key,
    required this.value,
    this.label,
    this.color,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final progressColor = color ?? colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: BauhausDesign.getTextTheme(context).labelSmall,
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: BauhausDesign.getTextTheme(
                  context,
                ).labelSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space1),
        ],
        Container(
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: colorScheme.outline, width: 1.5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
