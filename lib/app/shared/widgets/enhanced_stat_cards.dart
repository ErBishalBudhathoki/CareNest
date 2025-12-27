import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Enhanced StatCard widget with improved UX/UI features
class EnhancedStatCards extends StatelessWidget {
  final List<EnhancedStatCardData> cards;
  final EdgeInsets? padding;
  final double spacing;
  final bool animate;
  final Duration animationDuration;
  final int animationDelayMs;
  final bool responsive;

  const EnhancedStatCards({
    super.key,
    required this.cards,
    this.padding = const EdgeInsets.all(12.0),
    this.spacing = 12.0,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationDelayMs = 150,
    this.responsive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: responsive ? _buildResponsiveLayout() : _buildFixedLayout(),
    );
  }

  Widget _buildResponsiveLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 768;
        final isMobile = constraints.maxWidth <= 480;

        if (isMobile && cards.length > 2) {
          return _buildGridLayout(2);
        } else if (isTablet || cards.length <= 3) {
          return _buildRowLayout();
        } else {
          return _buildGridLayout(3);
        }
      },
    );
  }

  Widget _buildFixedLayout() {
    return _buildRowLayout();
  }

  Widget _buildRowLayout() {
    return Row(
      children: cards.asMap().entries.map((entry) {
        final index = entry.key;
        final card = entry.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < cards.length - 1 ? spacing : 0,
            ),
            child: EnhancedStatCard(
              data: card,
              animate: animate,
              animationDelay: Duration(milliseconds: index * animationDelayMs),
              animationDuration: animationDuration,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGridLayout(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1.2,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return EnhancedStatCard(
          data: cards[index],
          animate: animate,
          animationDelay: Duration(milliseconds: index * animationDelayMs),
          animationDuration: animationDuration,
        );
      },
    );
  }
}

/// Enhanced individual stat card widget
class EnhancedStatCard extends StatefulWidget {
  final EnhancedStatCardData data;
  final bool animate;
  final Duration animationDelay;
  final Duration animationDuration;

  const EnhancedStatCard({
    super.key,
    required this.data,
    this.animate = true,
    this.animationDelay = Duration.zero,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  State<EnhancedStatCard> createState() => _EnhancedStatCardState();
}

class _EnhancedStatCardState extends State<EnhancedStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget card = MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.data.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_hoverController.value * 0.02),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: widget.data.gradient ??
                      LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.data.surfaceColor ??
                              Colors.white,
                          (widget.data.surfaceColor ??
                                  Colors.white)
                              .withOpacity(0.1),
                        ],
                      ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                  border: widget.data.showBorder
                      ? Border.all(
                          color: (widget.data.color ?? const Color(0xFFE0E0E0))
                              .withOpacity(0.1),
                          width: 1,
                        )
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 8.0),
                    _buildValue(),
                    if (widget.data.trend != null) ...[
                      const SizedBox(height: 4.0),
                      _buildTrendIndicator(),
                    ],
                    if (widget.data.subtitle != null) ...[
                      const SizedBox(height: 16.0),
                      _buildSubtitle(),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

    // Apply accessibility semantics
    card = Semantics(
      label: widget.data.accessibilityLabel ??
          '${widget.data.title}: ${widget.data.value}',
      value: widget.data.trend != null
          ? '${widget.data.trend!.isPositive ? "Increased" : "Decreased"} by ${widget.data.trend!.percentage}%'
          : null,
      button: widget.data.onTap != null,
      child: card,
    );

    // Apply animations
    if (widget.animate) {
      return card
          .animate(delay: widget.animationDelay)
          .fadeIn(
            duration: widget.animationDuration,
            curve: Curves.easeOutCubic,
          )
          .slideY(
            begin: 0.3,
            end: 0,
            duration: widget.animationDuration,
            curve: Curves.easeOutCubic,
          )
          .scale(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1.0, 1.0),
            duration: widget.animationDuration,
            curve: Curves.easeOutCubic,
          );
    }

    return card;
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  Widget _buildHeader() {
    return Row(
      children: [
        if (widget.data.icon != null) ...[
          _buildIcon(),
          const SizedBox(width: 8.0),
        ],
        Expanded(
          child: Text(
            widget.data.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500).copyWith(
              color: widget.data.titleColor ?? const Color(0xFF6B7280),
              letterSpacing: 0.5,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        if (widget.data.actionIcon != null)
          IconButton(
            icon: Icon(
              widget.data.actionIcon,
              size: 16,
              color: const Color(0xFF9CA3AF),
            ),
            onPressed: widget.data.onActionTap,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: (widget.data.color ?? const Color(0xFF667EEA))
            .withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        widget.data.icon!,
        color: widget.data.color ?? const Color(0xFF667EEA),
        size: 20,
      ),
    );
  }

  Widget _buildValue() {
    return Text(
      widget.data.value,
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700).copyWith(
        color: widget.data.valueColor ?? const Color(0xFF1F2937),
        letterSpacing: -0.5,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildTrendIndicator() {
    final trend = widget.data.trend!;
    final isPositive = trend.isPositive;
    final color =
        isPositive ? Colors.green : Colors.red;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                size: 12,
                color: color,
              ),
              const SizedBox(width: 2),
              Text(
                '${trend.percentage}%',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500).copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        if (trend.period != null) ...[
          const SizedBox(width: 16.0),
          Text(
            trend.period!,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500).copyWith(
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      widget.data.subtitle!,
      style: const TextStyle(fontSize: 12).copyWith(
        color: widget.data.subtitleColor ?? const Color(0xFF6B7280),
        height: 1.3,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}

/// Enhanced data model for stat card information
class EnhancedStatCardData {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final IconData? actionIcon;
  final Color? color;
  final Color? surfaceColor;
  final Color? titleColor;
  final Color? valueColor;
  final Color? subtitleColor;
  final Gradient? gradient;
  final bool showBorder;
  final TrendData? trend;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;
  final String? accessibilityLabel;

  const EnhancedStatCardData({
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.actionIcon,
    this.color,
    this.surfaceColor,
    this.titleColor,
    this.valueColor,
    this.subtitleColor,
    this.gradient,
    this.showBorder = false,
    this.trend,
    this.onTap,
    this.onActionTap,
    this.accessibilityLabel,
  });

  /// Factory constructor for revenue card
  factory EnhancedStatCardData.revenue({
    required String value,
    TrendData? trend,
    VoidCallback? onTap,
  }) {
    return EnhancedStatCardData(
      title: 'Total Revenue',
      value: value,
      icon: Icons.attach_money,
      color: Colors.green,
      trend: trend,
      onTap: onTap,
      gradient: const LinearGradient(
        colors: [Color(0xFFE8F5E8), Color(0xFFF0F9F0)],
      ),
    );
  }

  /// Factory constructor for clients card
  factory EnhancedStatCardData.clients({
    required String value,
    TrendData? trend,
    VoidCallback? onTap,
  }) {
    return EnhancedStatCardData(
      title: 'Active Clients',
      value: value,
      icon: Icons.people,
      color: const Color(0xFF667EEA),
      trend: trend,
      onTap: onTap,
      gradient: const LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFF3F9FF)],
      ),
    );
  }

  /// Factory constructor for invoices card
  factory EnhancedStatCardData.invoices({
    required String value,
    TrendData? trend,
    VoidCallback? onTap,
  }) {
    return EnhancedStatCardData(
      title: 'Pending Invoices',
      value: value,
      icon: Icons.receipt_long,
      color: Colors.orange,
      trend: trend,
      onTap: onTap,
      gradient: const LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFF8F0)],
      ),
    );
  }
}

/// Data model for trend information
class TrendData {
  final double percentage;
  final bool isPositive;
  final String? period;

  const TrendData({
    required this.percentage,
    required this.isPositive,
    this.period,
  });

  factory TrendData.positive(double percentage, {String? period}) {
    return TrendData(
      percentage: percentage,
      isPositive: true,
      period: period,
    );
  }

  factory TrendData.negative(double percentage, {String? period}) {
    return TrendData(
      percentage: percentage,
      isPositive: false,
      period: period,
    );
  }
}
