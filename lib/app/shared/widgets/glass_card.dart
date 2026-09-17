import 'package:flutter/material.dart';
import 'package:blur/blur.dart';

/// DEPRECATED (Bauhaus): glassmorphism violates neo-brutalism (no blur,
/// no rounded 32, no soft elevation). Use [BauhausCard] instead.
/// Kept only for legacy call sites — do not use in new code.
@Deprecated('Use BauhausCard (squared, hard shadow) instead')
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double elevation;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.elevation = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Blur(
        blur: 20,
        borderRadius: BorderRadius.circular(32),
        colorOpacity: 0.06,
        child: Material(
          elevation: elevation,
          color: theme.colorScheme.surface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(32),
          shadowColor: Colors.black26,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(24),
            child: child,
          ),
        ),
      ),
    );
  }
}
