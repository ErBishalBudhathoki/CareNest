import 'package:flutter/material.dart';
import 'package:blur/blur.dart';

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
          color: theme.colorScheme.surface.withOpacity(0.1),
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
