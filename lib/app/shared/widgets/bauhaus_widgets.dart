import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
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
    Widget card = Container(
      margin: margin,
      padding: padding,
      decoration: BauhausDesign.cardDecoration.copyWith(
        color: backgroundColor ?? BauhausDesign.surfaceWhite,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1.5)
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
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
    final isPositiveChange = changePercentage != null && changePercentage! > 0;
    final changeColor = isPositiveChange
        ? BauhausDesign.success
        : BauhausDesign.warning;

    return BauhausCard(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxHeight < 110;
          final titleStyle = BauhausDesign.getTextTheme(
            context,
          ).bodyMedium?.copyWith(color: BauhausDesign.textMuted);
          final subtitleStyle = BauhausDesign.getTextTheme(
            context,
          ).bodyMedium?.copyWith(color: BauhausDesign.textMuted, fontSize: 12);

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
                        color: (iconColor ?? BauhausDesign.primary).withValues(alpha: 
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ?? BauhausDesign.primary,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: isLoading
                          ? Container(
                              height: 18,
                              color: BauhausDesign.neutral.withValues(alpha: 0.1),
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
                      color: (iconColor ?? BauhausDesign.primary).withValues(alpha: 
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusSm,
                      ),
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? BauhausDesign.primary,
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
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                        border: Border.all(
                          color: BauhausDesign.neutral,
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
                  color: BauhausDesign.neutral.withValues(alpha: 0.1),
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
    return Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return activeColor ?? BauhausDesign.primary;
            }
            return BauhausDesign.surfaceWhite;
          }),
          checkColor: WidgetStateProperty.all(
            checkColor ?? BauhausDesign.surfaceWhite,
          ),
          side: const BorderSide(color: BauhausDesign.neutral, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          ),
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
    Color effectiveColor = color ?? BauhausDesign.primary;
    Color textColor = BauhausDesign.textDark;

    if (color == null) {
      switch (variant) {
        case BauhausChipVariant.primary:
          effectiveColor = BauhausDesign.primary;
          textColor = BauhausDesign.surfaceWhite;
          break;
        case BauhausChipVariant.secondary:
          effectiveColor = BauhausDesign.secondary;
          textColor = BauhausDesign.surfaceWhite;
          break;
        case BauhausChipVariant.success:
          effectiveColor = BauhausDesign.success;
          textColor = BauhausDesign.surfaceWhite;
          break;
        case BauhausChipVariant.warning:
          effectiveColor = BauhausDesign.warning;
          textColor = BauhausDesign.textDark;
          break;
        case BauhausChipVariant.error:
          effectiveColor = BauhausDesign.error;
          textColor = BauhausDesign.surfaceWhite;
          break;
        case BauhausChipVariant.info:
          effectiveColor = BauhausDesign.info;
          textColor = BauhausDesign.surfaceWhite;
          break;
        case BauhausChipVariant.outlined:
          effectiveColor = BauhausDesign.surfaceWhite;
          textColor = BauhausDesign.textDark;
          break;
        case BauhausChipVariant.neutral:
          effectiveColor = BauhausDesign.neutral;
          textColor = BauhausDesign.surfaceWhite;
          break;
      }
    }

    if (isSelected) {
      if (variant == BauhausChipVariant.outlined) {
        effectiveColor = BauhausDesign.primary;
        textColor = BauhausDesign.surfaceWhite;
      }
    }

    return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: _padding,
            decoration: BauhausDesign.chipDecoration(
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
                        ? BauhausDesign.surfaceWhite
                        : BauhausDesign.textDark,
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
                              ? (variant == BauhausChipVariant.warning
                                    ? BauhausDesign.textDark
                                    : BauhausDesign.surfaceWhite)
                              : BauhausDesign.textDark,
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
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            decoration: BauhausDesign.inputDecoration(hintText).copyWith(
              prefixIcon:
                  prefixIcon ??
                  const Icon(Icons.search, color: BauhausDesign.textMuted),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: BauhausDesign.textMuted,
                      ),
                      onPressed: () {
                        controller.clear();
                        onClear?.call();
                      },
                    )
                  : suffixIcon,
            ),
          ),
        ),
        if (onFilterTap != null) ...[
          SizedBox(width: BauhausDesign.space3),
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
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
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
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BauhausDesign.space1),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines,
          enabled: enabled,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          style: BauhausDesign.getTextTheme(context).bodyMedium,
          decoration: BauhausDesign.inputDecoration(hintText ?? '').copyWith(
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
    Color effectiveBg = backgroundColor ?? BauhausDesign.primary;
    Color effectiveText = textColor ?? BauhausDesign.surfaceWhite;

    if (backgroundColor == null) {
      switch (variant) {
        case BauhausActionVariant.primary:
          effectiveBg = BauhausDesign.primary;
          effectiveText = BauhausDesign.surfaceWhite;
          break;
        case BauhausActionVariant.secondary:
          effectiveBg = BauhausDesign.surfaceWhite;
          effectiveText = BauhausDesign.primary;
          break;
        case BauhausActionVariant.success:
          effectiveBg = BauhausDesign.success;
          effectiveText = BauhausDesign.surfaceWhite;
          break;
        case BauhausActionVariant.warning:
          effectiveBg = BauhausDesign.warning;
          effectiveText = BauhausDesign.textDark;
          break;
        case BauhausActionVariant.error:
        case BauhausActionVariant.danger:
          effectiveBg = BauhausDesign.error;
          effectiveText = BauhausDesign.surfaceWhite;
          break;
        case BauhausActionVariant.info:
          effectiveBg = BauhausDesign.info;
          effectiveText = BauhausDesign.surfaceWhite;
          break;
        case BauhausActionVariant.ghost:
          effectiveBg = Colors.transparent;
          effectiveText = BauhausDesign.textDark;
          break;
        case BauhausActionVariant.neutral:
          effectiveBg = BauhausDesign.surfaceWhite;
          effectiveText = BauhausDesign.textDark;
          break;
      }
    }

    if (isOutlined) {
      effectiveText =
          textColor ??
          effectiveBg; // Text color matches the 'color' of the button unless explicit textColor provided
      effectiveBg = BauhausDesign.surfaceWhite;
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
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(
          color: isOutlined ? effectiveText : BauhausDesign.neutral,
          width: 1.5,
        ),
        boxShadow:
            isOutlined ||
                backgroundColor == BauhausDesign.neutral.withValues(alpha: 0.2)
            ? [] // No shadow for outlined or disabled/neutral-ghost buttons
            : [BauhausDesign.shadowHard],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
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
    final label = semanticsLabel ?? text;
    if (label == null || label.trim().isEmpty) {
      return child;
    }

    return Semantics(
      button: true,
      enabled: onPressed != null && !isLoading,
      label: label,
      excludeSemantics: true,
      child: child,
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
    Color effectiveBg;
    Color effectiveIconColor;
    Color effectiveBorderColor = BauhausDesign.neutral;

    switch (variant) {
      case BauhausActionVariant.primary:
        effectiveBg = BauhausDesign.primary;
        effectiveIconColor = BauhausDesign.surfaceWhite;
        effectiveBorderColor = BauhausDesign.primary;
        break;
      case BauhausActionVariant.secondary:
        effectiveBg = BauhausDesign.secondary;
        effectiveIconColor = BauhausDesign.surfaceWhite;
        effectiveBorderColor = BauhausDesign.secondary;
        break;
      case BauhausActionVariant.neutral:
        effectiveBg = BauhausDesign.surfaceWhite;
        effectiveIconColor = BauhausDesign.textDark;
        effectiveBorderColor = BauhausDesign.neutral;
        break;
      case BauhausActionVariant.ghost:
        effectiveBg = Colors.transparent;
        effectiveIconColor = BauhausDesign.textDark;
        effectiveBorderColor = Colors.transparent;
        break;
      default:
        effectiveBg = BauhausDesign.surfaceWhite;
        effectiveIconColor = BauhausDesign.textDark;
        effectiveBorderColor = BauhausDesign.neutral;
    }

    Widget button =
        Container(
              width: isSmall ? 32 : 40,
              height: isSmall ? 32 : 40,
              decoration: BoxDecoration(
                color: effectiveBg,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: variant != BauhausActionVariant.ghost
                    ? Border.all(color: effectiveBorderColor, width: 1.5)
                    : null,
                boxShadow: variant != BauhausActionVariant.ghost
                    ? const [BauhausDesign.shadowSoft]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  child: Icon(
                    icon,
                    color: effectiveIconColor,
                    size: isSmall ? 16 : 20,
                  ),
                ),
              ),
            )
            .animate(target: onPressed != null ? 1 : 0)
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(0.95, 0.95),
              duration: 100.ms,
            );

    if (tooltip != null) {
      return Tooltip(message: tooltip, child: button);
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Icon(icon, size: 48, color: BauhausDesign.textMuted),
            ),
            const SizedBox(height: BauhausDesign.space6),
            Text(
              title,
              style: BauhausDesign.getTextTheme(
                context,
              ).headlineMedium?.copyWith(color: BauhausDesign.textDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              _effectiveMessage,
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
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
                color: (color ?? BauhausDesign.primary).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1),
              ),
              alignment: Alignment.center,
              child: IconTheme(
                data: IconThemeData(
                  color: color ?? BauhausDesign.primary,
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
                          color: BauhausDesign.textDark,
                        ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: BauhausDesign.getTextTheme(context).bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
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
                  color: BauhausDesign.backgroundLight,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: BauhausDesign.textDark,
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
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    subtitle!,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(BauhausDesign.primary),
            strokeWidth: 3,
          ),
          if (showMessage) ...[
            const SizedBox(height: BauhausDesign.space4),
            Text(
              message ?? 'Loading...',
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
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
    final progressColor = color ?? BauhausDesign.primary;

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
            color: BauhausDesign.neutral.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
            border: Border.all(color: BauhausDesign.neutral, width: 1),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
