import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Bauhaus Metric Card with Trend Indicators
class BauhausMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final double? trend;
  final String? trendLabel;
  final VoidCallback? onTap;
  final bool isLoading;

  const BauhausMetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    this.trend,
    this.trendLabel,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return BauhausStatCard(
      title: title,
      value: value,
      subtitle: subtitle,
      icon: icon,
      iconColor: iconColor,
      changePercentage: trend,
      onTap: onTap,
      isLoading: isLoading,
    );
  }
}

/// Bauhaus Action Card for Quick Actions
class BauhausActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isEnabled;

  const BauhausActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return BauhausCard(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          onTap: isEnabled ? onTap : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with background
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
                ),
                child: Icon(icon, color: color, size: 20),
              ),

              const SizedBox(height: BauhausDesign.space3),

              // Title
              Text(
                title,
                style: BauhausDesign.getTextTheme(
                  context,
                ).titleMedium?.copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: BauhausDesign.space1),

              // Subtitle
              Expanded(
                child: Text(
                  subtitle,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Arrow indicator
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: BauhausDesign.textMuted,
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

/// Bauhaus Chart Widget Placeholder
class BauhausChartWidget extends StatelessWidget {
  final String title;
  final List<ChartData> data;
  final ChartType type;
  final Color primaryColor;
  final double height;

  const BauhausChartWidget({
    super.key,
    required this.title,
    required this.data,
    this.type = ChartType.line,
    this.primaryColor = BauhausDesign.primary,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: BauhausDesign.getTextTheme(
                  context,
                ).titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              BauhausChip(
                label: _getChartTypeLabel(context),
                variant: BauhausChipVariant.outlined,
              ),
            ],
          ),

          const SizedBox(height: BauhausDesign.space4),

          // Chart placeholder
          Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(
                color: primaryColor.withValues(alpha: 0.1),
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
                    color: primaryColor.withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  Text(
                    AppLocalizations.of(context)!.chartVisualizationPlaceholder,
                    textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodySmall?.copyWith(color: primaryColor.withValues(alpha: 0.5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 400.ms);
  }

  String _getChartTypeLabel(BuildContext context) {
    switch (type) {
      case ChartType.line:
        return AppLocalizations.of(context)!.lineChart;
      case ChartType.bar:
        return AppLocalizations.of(context)!.barChart;
      case ChartType.pie:
        return AppLocalizations.of(context)!.pieChart;
      case ChartType.area:
        return AppLocalizations.of(context)!.areaChart;
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

/// Bauhaus Activity Item for Timeline
class BauhausActivityItem extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;
  final IconData icon;
  final Color color;
  final bool isLast;

  const BauhausActivityItem({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.color,
    this.isLast = false,
  });

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
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: color, width: 1.5),
              ),
              child: Icon(icon, size: 16, color: color),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: BauhausDesign.neutral,
                margin: const EdgeInsets.symmetric(vertical: 4.0),
              ),
          ],
        ),

        const SizedBox(width: BauhausDesign.space3),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: BauhausDesign.getTextTheme(
                  context,
                ).titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: BauhausDesign.space1),
              Text(
                description,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
              const SizedBox(height: BauhausDesign.space1),
              Text(
                timestamp,
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
              ),
              if (!isLast) const SizedBox(height: BauhausDesign.space4),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3, end: 0);
  }
}

/// Bauhaus Loading Skeleton
class BauhausLoadingSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const BauhausLoadingSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: BauhausDesign.neutral.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: Colors.white.withValues(alpha: 0.5));
  }
}

// Data Models
class ChartData {
  final String label;
  final double value;
  final Color? color;

  ChartData({required this.label, required this.value, this.color});
}

enum ChartType { line, bar, pie, area }

class MetricData {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final double trend;
  final String trendLabel;

  MetricData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.trend,
    required this.trendLabel,
  });
}

class QuickActionData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  QuickActionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class ActivityData {
  final String title;
  final String description;
  final String timestamp;
  final IconData icon;
  final Color color;

  ActivityData({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.color,
  });
}
