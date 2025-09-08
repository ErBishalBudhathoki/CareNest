import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

/// Enhanced Quick Action Cards with improved UX
class EnhancedQuickActionGrid extends StatelessWidget {
  final List<QuickActionData> actions;
  final EdgeInsets? padding;
  final double spacing;
  final bool animate;
  final int crossAxisCount;

  const EnhancedQuickActionGrid({
    super.key,
    required this.actions,
    this.padding = const EdgeInsets.all(ModernSaasDesign.space3),
    this.spacing = ModernSaasDesign.space3,
    this.animate = true,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: 1.3,
        ),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          return EnhancedQuickActionCard(
            data: actions[index],
            animate: animate,
            animationDelay: Duration(milliseconds: index * 100),
          );
        },
      ),
    );
  }
}

/// Enhanced Quick Action Card
class EnhancedQuickActionCard extends StatefulWidget {
  final QuickActionData data;
  final bool animate;
  final Duration animationDelay;

  const EnhancedQuickActionCard({
    super.key,
    required this.data,
    this.animate = true,
    this.animationDelay = Duration.zero,
  });

  @override
  State<EnhancedQuickActionCard> createState() =>
      _EnhancedQuickActionCardState();
}

class _EnhancedQuickActionCardState extends State<EnhancedQuickActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget card = GestureDetector(
      onTapDown: (_) => _onPressChange(true),
      onTapUp: (_) => _onPressChange(false),
      onTapCancel: () => _onPressChange(false),
      onTap: widget.data.onTap,
      child: AnimatedBuilder(
        animation: _pressController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (_pressController.value * 0.05),
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.data.gradient ??
                    LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.data.color.withValues(alpha: 0.1),
                        widget.data.color.withValues(alpha: 0.05),
                      ],
                    ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.data.color.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: widget.data.color.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(ModernSaasDesign.space4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcon(),
                    const SizedBox(height: ModernSaasDesign.space2),
                    _buildTitle(),
                    if (widget.data.subtitle != null) ...[
                      const SizedBox(height: ModernSaasDesign.space1),
                      _buildSubtitle(),
                    ],
                    if (widget.data.badge != null) ...[
                      const SizedBox(height: ModernSaasDesign.space1),
                      _buildBadge(),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    // Apply accessibility
    card = Semantics(
      label: widget.data.accessibilityLabel ?? widget.data.title,
      hint: widget.data.subtitle,
      button: true,
      child: card,
    );

    // Apply animations
    if (widget.animate) {
      return card
          .animate(delay: widget.animationDelay)
          .fadeIn(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
          )
          .slideY(
            begin: 0.3,
            end: 0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
          );
    }

    return card;
  }

  void _onPressChange(bool isPressed) {
    setState(() {
      _isPressed = isPressed;
    });
    if (isPressed) {
      _pressController.forward();
    } else {
      _pressController.reverse();
    }
  }

  Widget _buildIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.data.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        widget.data.icon,
        color: widget.data.color,
        size: 24,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.data.title,
      style: ModernSaasDesign.bodyLarge.copyWith(
        fontWeight: FontWeight.w600,
        color: ModernSaasDesign.textPrimary,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      widget.data.subtitle!,
      style: ModernSaasDesign.bodySmall.copyWith(
        color: ModernSaasDesign.textSecondary,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ModernSaasDesign.space2,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: widget.data.badgeColor ?? ModernSaasDesign.error,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        widget.data.badge!,
        style: ModernSaasDesign.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
          color: ModernSaasDesign.textOnPrimary,
        ),
      ),
    );
  }
}

/// Data model for quick action
class QuickActionData {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final Gradient? gradient;
  final VoidCallback onTap;
  final String? badge;
  final Color? badgeColor;
  final String? accessibilityLabel;

  const QuickActionData({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.subtitle,
    this.gradient,
    this.badge,
    this.badgeColor,
    this.accessibilityLabel,
  });

  /// Factory for pricing actions
  factory QuickActionData.pricing({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    String? subtitle,
    String? badge,
  }) {
    return QuickActionData(
      title: title,
      icon: icon,
      color: ModernSaasDesign.primary,
      onTap: onTap,
      subtitle: subtitle,
      badge: badge,
      gradient: const LinearGradient(
        colors: [Color(0xFFE8E3F3), Color(0xFFF5F2FF)],
      ),
    );
  }
}
