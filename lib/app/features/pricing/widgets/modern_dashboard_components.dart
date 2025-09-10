import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../shared/design_system/modern_saas_design_system.dart';

/// Modern Metric Card with Trend Indicators
class ModernMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final double? trend;
  final String? trendLabel;
  final VoidCallback? onTap;
  final bool isLoading;

  const ModernMetricCard({
    Key? key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    this.trend,
    this.trendLabel,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      padding: const EdgeInsets.all(ModernSaasDesign.space3), // Reduced padding
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Use minimum space
        children: [
          // Header with icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(
                    ModernSaasDesign.space1), // Reduced padding
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusMd),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 18, // Slightly smaller
                ),
              ),
              if (trend != null) _buildTrendIndicator(),
            ],
          ),

          const SizedBox(height: ModernSaasDesign.space2), // Reduced spacing

          // Title
          Text(
            title,
            style: ModernSaasDesign.bodyMedium.copyWith(
              fontSize: 13, // Slightly smaller
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: ModernSaasDesign.space1),

          // Value
          if (isLoading)
            Container(
              height: 28, // Reduced height
              width: double.infinity,
              decoration: BoxDecoration(
                color: ModernSaasDesign.neutral200,
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusSm),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1500.ms)
          else
            Text(
              value,
              style: ModernSaasDesign.displaySmall.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20, // Slightly smaller
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

          if (subtitle != null) ...[
            const SizedBox(height: ModernSaasDesign.space1),
            Text(
              subtitle!,
              style: ModernSaasDesign.bodySmall.copyWith(
                fontSize: 11, // Slightly smaller
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildTrendIndicator() {
    final isPositive = trend! >= 0;
    final color =
        isPositive ? ModernSaasDesign.success : ModernSaasDesign.error;
    final icon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ModernSaasDesign.space2,
        vertical: ModernSaasDesign.space1,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: ModernSaasDesign.space1),
          Text(
            '${isPositive ? '+' : ''}${trend!.toStringAsFixed(1)}%',
            style: ModernSaasDesign.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Modern Action Card for Quick Actions
class ModernActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isEnabled;

  const ModernActionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      padding: const EdgeInsets.all(ModernSaasDesign.space3), // Reduced padding
      onTap: isEnabled ? onTap : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Use minimum space
        children: [
          // Icon with gradient background
          Container(
            width: 40, // Reduced size
            height: 40, // Reduced size
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20, // Reduced size
            ),
          ),

          const SizedBox(height: ModernSaasDesign.space2), // Reduced spacing

          // Title
          Text(
            title,
            style: ModernSaasDesign.headlineSmall.copyWith(
              fontSize: 14, // Slightly smaller
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: ModernSaasDesign.space1),

          // Subtitle
          Expanded(
            child: Text(
              subtitle,
              style: ModernSaasDesign.bodySmall.copyWith(
                fontSize: 11, // Slightly smaller
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Arrow indicator
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 10, // Reduced size
              color: ModernSaasDesign.textTertiary,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideX(begin: 0.3, end: 0);
  }
}

/// Modern Chart Widget Placeholder
class ModernChartWidget extends StatelessWidget {
  final String title;
  final List<ChartData> data;
  final ChartType type;
  final Color primaryColor;
  final double height;

  const ModernChartWidget({
    Key? key,
    required this.title,
    required this.data,
    this.type = ChartType.line,
    this.primaryColor = ModernSaasDesign.primary,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: ModernSaasDesign.headlineSmall,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space2,
                  vertical: ModernSaasDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: ModernSaasDesign.neutral100,
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusSm),
                ),
                child: Text(
                  _getChartTypeLabel(),
                  style: ModernSaasDesign.labelSmall,
                ),
              ),
            ],
          ),

          const SizedBox(height: ModernSaasDesign.space4),

          // Chart placeholder
          Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withValues(alpha: 0.1),
                  primaryColor.withValues(alpha: 0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              border: Border.all(
                color: primaryColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getChartIcon(),
                    size: 48,
                    color: primaryColor.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: ModernSaasDesign.space2),
                  Text(
                    'Chart visualization\nwould appear here',
                    textAlign: TextAlign.center,
                    style: ModernSaasDesign.bodySmall.copyWith(
                      color: primaryColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 400.ms);
  }

  String _getChartTypeLabel() {
    switch (type) {
      case ChartType.line:
        return 'Line Chart';
      case ChartType.bar:
        return 'Bar Chart';
      case ChartType.pie:
        return 'Pie Chart';
      case ChartType.area:
        return 'Area Chart';
    }
  }

  IconData _getChartIcon() {
    switch (type) {
      case ChartType.line:
        return Icons.show_chart;
      case ChartType.bar:
        return Icons.bar_chart;
      case ChartType.pie:
        return Icons.pie_chart;
      case ChartType.area:
        return Icons.area_chart;
    }
  }
}

/// Modern Activity Item for Timeline
class ModernActivityItem extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;
  final IconData icon;
  final Color color;
  final bool isLast;

  const ModernActivityItem({
    Key? key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.color,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(ModernSaasDesign.radiusFull),
                border: Border.all(
                  color: color,
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 16,
                color: color,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: ModernSaasDesign.border,
                margin: const EdgeInsets.symmetric(
                  vertical: ModernSaasDesign.space1,
                ),
              ),
          ],
        ),

        const SizedBox(width: ModernSaasDesign.space3),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: ModernSaasDesign.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: ModernSaasDesign.space1),
              Text(
                description,
                style: ModernSaasDesign.bodyMedium,
              ),
              const SizedBox(height: ModernSaasDesign.space1),
              Text(
                timestamp,
                style: ModernSaasDesign.bodySmall,
              ),
              if (!isLast) const SizedBox(height: ModernSaasDesign.space4),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3, end: 0);
  }
}

/// Modern Search Bar
class ModernSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final bool showFilter;

  const ModernSearchBar({
    Key? key,
    this.hintText = 'Search...',
    this.onChanged,
    this.onFilterTap,
    this.showFilter = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
        border: Border.all(
          color: ModernSaasDesign.border,
          width: 1,
        ),
        boxShadow: ModernSaasDesign.shadowSm,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: ModernSaasDesign.bodyMedium,
                prefixIcon: Icon(
                  Icons.search,
                  color: ModernSaasDesign.textTertiary,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space4,
                  vertical: ModernSaasDesign.space3,
                ),
              ),
            ),
          ),
          if (showFilter)
            Container(
              margin: const EdgeInsets.only(right: ModernSaasDesign.space2),
              child: IconButton(
                onPressed: onFilterTap,
                icon: Icon(
                  Icons.tune,
                  color: ModernSaasDesign.textSecondary,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: ModernSaasDesign.neutral100,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusMd),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Modern Loading Skeleton
class ModernLoadingSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ModernLoadingSkeleton({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ModernSaasDesign.neutral200,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms);
  }
}

// Data Models
class ChartData {
  final String label;
  final double value;
  final Color? color;

  ChartData({
    required this.label,
    required this.value,
    this.color,
  });
}

enum ChartType { line, bar, pie, area }
