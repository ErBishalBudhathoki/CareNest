import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

/// A reusable widget for displaying statistical information in card format
/// Supports both single card and multiple cards in a row layout
class StatCards extends StatelessWidget {
  final List<StatCardData> cards;
  final EdgeInsets? padding;
  final double spacing;
  final bool animate;
  final Duration animationDuration;
  final int animationDelayMs;

  const StatCards({
    super.key,
    required this.cards,
    this.padding = const EdgeInsets.all(BauhausDesign.space4),
    this.spacing = BauhausDesign.space4,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationDelayMs = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        children: cards.asMap().entries.map((entry) {
          final index = entry.key;
          final card = entry.value;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index < cards.length - 1 ? spacing : 0,
              ),
              child: StatCard(
                data: card,
                animate: animate,
                animationDelay: Duration(
                  milliseconds: index * animationDelayMs,
                ),
                animationDuration: animationDuration,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Individual stat card widget (Bauhaus Style)
class StatCard extends StatelessWidget {
  final StatCardData data;
  final bool animate;
  final Duration animationDelay;
  final Duration animationDuration;

  const StatCard({
    super.key,
    required this.data,
    this.animate = true,
    this.animationDelay = Duration.zero,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BauhausDesign.cardDecoration.copyWith(
        color: data.surfaceColor ?? BauhausDesign.surfaceWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (data.icon != null) _buildIconRow(context),
          if (data.icon == null) _buildValueRow(context),
          const SizedBox(height: BauhausDesign.space2),
          _buildTitle(context),
          if (data.subtitle != null) _buildSubtitle(context),
        ],
      ),
    );

    // Apply smooth animations with staggered effect
    if (animate) {
      return card
          .animate(delay: animationDelay)
          .fadeIn(duration: animationDuration, curve: Curves.easeOutCubic)
          .scale(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1.0, 1.0),
            duration: animationDuration,
            curve: Curves.easeOutCubic,
          );
    }

    return card;
  }

  /// Builds the icon row with icon and value - Fixed overflow issue
  Widget _buildIconRow(BuildContext context) {
    return Row(
      children: [
        // Icon with fixed size
        SizedBox(
          width: 48,
          child: data.iconContainer
              ? _buildContainerIcon()
              : _buildSimpleIcon(),
        ),
        const SizedBox(width: BauhausDesign.space2),
        // Flexible text to prevent overflow
        Expanded(
          child: Text(
            data.value,
            style: BauhausDesign.getTextTheme(context).displayMedium?.copyWith(
              color: data.valueColor ?? data.color ?? BauhausDesign.textDark,
              fontSize: 24, // Adjusted for card size
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  /// Builds the value row when no icon is present - Fixed overflow issue
  Widget _buildValueRow(BuildContext context) {
    return Text(
      data.value,
      style: BauhausDesign.getTextTheme(context).displayMedium?.copyWith(
        color: data.valueColor ?? data.color ?? BauhausDesign.textDark,
        fontSize: 24,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  /// Builds the title with proper overflow handling
  Widget _buildTitle(BuildContext context) {
    return Text(
      data.title,
      style: BauhausDesign.getTextTheme(
        context,
      ).labelLarge?.copyWith(color: data.titleColor ?? BauhausDesign.textDark),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  /// Builds the container-style icon with consistent sizing
  Widget _buildContainerIcon() {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (data.color ?? BauhausDesign.neutral).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Icon(
        data.icon!,
        color: data.color ?? BauhausDesign.neutral,
        size: 24,
      ),
    );
  }

  /// Builds the simple icon with consistent sizing
  Widget _buildSimpleIcon() {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      child: Icon(
        data.icon!,
        color: data.color ?? BauhausDesign.neutral,
        size: 24,
      ),
    );
  }

  /// Builds the subtitle section with overflow handling
  Widget _buildSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4),
        Text(
          data.subtitle!,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
            color: data.subtitleColor ?? BauhausDesign.textMuted,
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}

/// Data model for stat card information
class StatCardData {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final Color? surfaceColor;
  final Color? titleColor;
  final Color? valueColor;
  final Color? subtitleColor;
  final bool iconContainer;
  final bool showBorder;

  const StatCardData({
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color,
    this.surfaceColor,
    this.titleColor,
    this.valueColor,
    this.subtitleColor,
    this.iconContainer = true,
    this.showBorder = false,
  });

  /// Factory constructor for creating a simple stat card
  factory StatCardData.simple({
    required String title,
    required String value,
    String? subtitle,
    IconData? icon,
    Color? color,
  }) {
    return StatCardData(
      title: title,
      value: value,
      subtitle: subtitle,
      icon: icon,
      color: color,
      iconContainer: false,
    );
  }

  /// Factory constructor for creating a bordered stat card
  factory StatCardData.bordered({
    required String title,
    required String value,
    String? subtitle,
    IconData? icon,
    Color? color,
  }) {
    return StatCardData(
      title: title,
      value: value,
      subtitle: subtitle,
      icon: icon,
      color: color,
      showBorder: true,
    );
  }
}
