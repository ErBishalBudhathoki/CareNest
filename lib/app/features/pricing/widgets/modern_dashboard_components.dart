import 'package:carenest/app/features/expenses/views/modern_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    return ModernCard(
      padding: const EdgeInsets.all(12.0), // Reduced padding
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
                    4.0), // Reduced padding
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(8.0),
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

          const SizedBox(height: 8.0), // Reduced spacing

          // Title
          Text(
            title,
            style: const TextStyle(fontSize: 14).copyWith(
              fontSize: 13, // Slightly smaller
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4.0),

          // Value
          if (isLoading)
            Container(
              height: 28, // Reduced height
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(4.0),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1500.ms)
          else
            Text(
              value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700).copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20, // Slightly smaller
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

          if (subtitle != null) ...[
            const SizedBox(height: 4.0),
            Text(
              subtitle!,
              style: const TextStyle(fontSize: 12).copyWith(
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
        isPositive ? Colors.green : Colors.red;
    final icon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4.0),
          Text(
            '${isPositive ? '+' : ''}${trend!.toStringAsFixed(1)}%',
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500).copyWith(
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
    return ModernCard(
      padding: const EdgeInsets.all(12.0), // Reduced padding
      onTap: isEnabled ? onTap : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Use minimum space
        children: [
          // Icon with gradient surface
          Container(
            width: 40, // Reduced size
            height: 40, // Reduced size
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
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

          const SizedBox(height: 8.0), // Reduced spacing

          // Title
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
              fontSize: 14, // Slightly smaller
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4.0),

          // Subtitle
          Expanded(
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 12).copyWith(
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
              color: const Color(0xFF9CA3AF),
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
    super.key,
    required this.title,
    required this.data,
    this.type = ChartType.line,
    this.primaryColor = const Color(0xFF667EEA),
    this.height = 200,
  });

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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius:
                      BorderRadius.circular(4.0),
                ),
                child: Text(
                  _getChartTypeLabel(),
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Chart placeholder
          Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.1),
                  primaryColor.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: primaryColor.withOpacity(0.1),
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
                    color: primaryColor.withOpacity(0.1),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Chart visualization\nwould appear here',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12).copyWith(
                      color: primaryColor.withOpacity(0.1),
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
                color: color.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(999.0),
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
                color: const Color(0xFFE0E0E0),
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
              ),
          ],
        ),

        const SizedBox(width: 12.0),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4.0),
              Text(
                timestamp,
                style: const TextStyle(fontSize: 12),
              ),
              if (!isLast) const SizedBox(height: 16.0),
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
    super.key,
    this.hintText = 'Search...',
    this.onChanged,
    this.onFilterTap,
    this.showFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 14),
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xFF9CA3AF),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),
          if (showFilter)
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: onFilterTap,
                icon: Icon(
                  Icons.tune,
                  color: const Color(0xFF6B7280),
                ),
                style: IconButton.styleFrom(backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0),
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
        color: const Color(0xFFE5E5E5),
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
