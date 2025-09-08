import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

/// Enhanced design system for modern, clean UI
class EnhancedDesignSystem {
  // Clean color palette
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color infoColor = Color(0xFF3B82F6);

  // Neutral colors
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Surface colors
  static const Color surfaceWhite = Colors.white;
  static const Color surfaceGray = gray50;
  static const Color borderColor = gray200;

  // Spacing system (8px grid)
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;

  // Border radius
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;

  // Shadows
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 6,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 2,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 15,
      offset: Offset(0, 10),
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 6,
      offset: Offset(0, 4),
    ),
  ];

  // Typography
  static const TextStyle headingXl = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.025,
    height: 1.2,
    color: gray900,
  );

  static const TextStyle headingLg = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.025,
    height: 1.3,
    color: gray900,
  );

  static const TextStyle headingMd = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: gray900,
  );

  static const TextStyle headingSm = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: gray900,
  );

  static const TextStyle bodyLg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: gray700,
  );

  static const TextStyle bodyMd = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: gray700,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: gray600,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
    color: gray500,
  );
}

/// Enhanced stat card with clean design
class EnhancedStatCard extends StatefulWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool isLoading;

  const EnhancedStatCard({
    Key? key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<EnhancedStatCard> createState() => _EnhancedStatCardState();
}

class _EnhancedStatCardState extends State<EnhancedStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(EnhancedDesignSystem.space4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusLg),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.4)
                  : EnhancedDesignSystem.borderColor.withValues(alpha: 0.8),
              width: _isHovered ? 2 : 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: widget.isLoading ? _buildLoadingSkeleton() : _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Header with icon and arrow
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.12),
                borderRadius:
                    BorderRadius.circular(EnhancedDesignSystem.radiusMd),
              ),
              child: Icon(
                widget.icon,
                size: 18,
                color: widget.color,
              ),
            ),
            if (widget.onTap != null)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: EnhancedDesignSystem.gray100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                  color: EnhancedDesignSystem.gray500,
                ),
              ),
          ],
        ),

        // Main content area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: EnhancedDesignSystem.space2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Value
                Text(
                  widget.value,
                  style: EnhancedDesignSystem.headingLg.copyWith(
                    color: EnhancedDesignSystem.gray900,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                    fontSize: 22,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),

                // Title
                Text(
                  widget.title,
                  style: EnhancedDesignSystem.bodyMd.copyWith(
                    color: EnhancedDesignSystem.gray700,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),

        // Subtitle at bottom
        if (widget.subtitle != null)
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.subtitle!,
              style: EnhancedDesignSystem.bodySm.copyWith(
                color: EnhancedDesignSystem.gray600,
                fontWeight: FontWeight.w500,
                height: 1.2,
                fontSize: 11,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: EnhancedDesignSystem.gray200,
                borderRadius:
                    BorderRadius.circular(EnhancedDesignSystem.radiusMd),
              ),
            ),
            const Spacer(),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: EnhancedDesignSystem.gray200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: EnhancedDesignSystem.space2),
        Container(
          width: 60,
          height: 20,
          decoration: BoxDecoration(
            color: EnhancedDesignSystem.gray200,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: EnhancedDesignSystem.space1),
        Container(
          width: 80,
          height: 12,
          decoration: BoxDecoration(
            color: EnhancedDesignSystem.gray200,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: Colors.white.withValues(alpha: 0.5));
  }
}

/// Enhanced search bar with modern design
class EnhancedSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onFilterTap;
  final VoidCallback? onAddTap;
  final List<String> activeFilters;

  const EnhancedSearchBar({
    Key? key,
    required this.controller,
    this.hintText = 'Search...',
    this.onFilterTap,
    this.onAddTap,
    this.activeFilters = const [],
  }) : super(key: key);

  @override
  State<EnhancedSearchBar> createState() => _EnhancedSearchBarState();
}

class _EnhancedSearchBarState extends State<EnhancedSearchBar> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(EnhancedDesignSystem.space6),
      decoration: BoxDecoration(
        color: EnhancedDesignSystem.surfaceWhite,
        border: Border(
          bottom: BorderSide(
            color: EnhancedDesignSystem.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: EnhancedDesignSystem.gray50,
                    borderRadius:
                        BorderRadius.circular(EnhancedDesignSystem.radiusLg),
                    border: Border.all(
                      color: _isFocused
                          ? EnhancedDesignSystem.primaryColor
                          : EnhancedDesignSystem.borderColor,
                      width: _isFocused ? 2 : 1,
                    ),
                  ),
                  child: TextField(
                    controller: widget.controller,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: EnhancedDesignSystem.bodyMd.copyWith(
                        color: EnhancedDesignSystem.gray400,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: EnhancedDesignSystem.gray400,
                        size: 20,
                      ),
                      suffixIcon: widget.controller.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: EnhancedDesignSystem.gray400,
                                size: 20,
                              ),
                              onPressed: () {
                                widget.controller.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: EnhancedDesignSystem.space4,
                        vertical: EnhancedDesignSystem.space3,
                      ),
                    ),
                    style: EnhancedDesignSystem.bodyMd,
                    onTap: () => setState(() => _isFocused = true),
                    onTapOutside: (_) => setState(() => _isFocused = false),
                  ),
                ),
              ),
              const SizedBox(width: EnhancedDesignSystem.space3),
              _buildActionButton(
                icon: Icons.tune,
                onTap: widget.onFilterTap,
                badge: widget.activeFilters.length,
              ),
              const SizedBox(width: EnhancedDesignSystem.space2),
              _buildActionButton(
                icon: Icons.add,
                onTap: widget.onAddTap,
                isPrimary: true,
              ),
            ],
          ),
          if (widget.activeFilters.isNotEmpty) ...<Widget>[
            const SizedBox(height: EnhancedDesignSystem.space4),
            _buildActiveFilters(),
          ]
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    VoidCallback? onTap,
    int badge = 0,
    bool isPrimary = false,
  }) {
    return Stack(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isPrimary
                ? EnhancedDesignSystem.primaryColor
                : EnhancedDesignSystem.surfaceWhite,
            borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusLg),
            border: isPrimary
                ? null
                : Border.all(color: EnhancedDesignSystem.borderColor),
            boxShadow: EnhancedDesignSystem.shadowSm,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius:
                  BorderRadius.circular(EnhancedDesignSystem.radiusLg),
              child: Icon(
                icon,
                color: isPrimary ? Colors.white : EnhancedDesignSystem.gray600,
                size: 20,
              ),
            ),
          ),
        ),
        if (badge > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: EnhancedDesignSystem.errorColor,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                badge.toString(),
                style: EnhancedDesignSystem.caption.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActiveFilters() {
    return Wrap(
      spacing: EnhancedDesignSystem.space2,
      runSpacing: EnhancedDesignSystem.space2,
      children: widget.activeFilters.map((filter) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: EnhancedDesignSystem.space3,
            vertical: EnhancedDesignSystem.space1,
          ),
          decoration: BoxDecoration(
            color: EnhancedDesignSystem.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusSm),
            border: Border.all(
              color: EnhancedDesignSystem.primaryColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                filter,
                style: EnhancedDesignSystem.bodySm.copyWith(
                  color: EnhancedDesignSystem.primaryColor,
                ),
              ),
              const SizedBox(width: EnhancedDesignSystem.space1),
              GestureDetector(
                onTap: () {
                  // Remove filter logic would go here
                },
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: EnhancedDesignSystem.primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

/// Enhanced rate card with clean design
class EnhancedRateCard extends StatefulWidget {
  final Map<String, dynamic> rate;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleSelect;

  const EnhancedRateCard({
    Key? key,
    required this.rate,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleSelect,
  }) : super(key: key);

  @override
  State<EnhancedRateCard> createState() => _EnhancedRateCardState();
}

class _EnhancedRateCardState extends State<EnhancedRateCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final status = widget.rate['status'] as String;
    final statusColor = _getStatusColor(status);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: EnhancedDesignSystem.space4),
        decoration: BoxDecoration(
          color: EnhancedDesignSystem.surfaceWhite,
          borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusLg),
          border: Border.all(
            color: widget.isSelected
                ? EnhancedDesignSystem.primaryColor
                : _isHovered
                    ? EnhancedDesignSystem.gray300
                    : EnhancedDesignSystem.borderColor,
            width: widget.isSelected ? 2 : 1,
          ),
          boxShadow: _isHovered
              ? EnhancedDesignSystem.shadowMd
              : EnhancedDesignSystem.shadowSm,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusLg),
            child: Padding(
              padding: const EdgeInsets.all(EnhancedDesignSystem.space6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(statusColor),
                  const SizedBox(height: EnhancedDesignSystem.space4),
                  _buildRateInfo(),
                  const SizedBox(height: EnhancedDesignSystem.space4),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color statusColor) {
    return Row(
      children: [
        if (widget.onToggleSelect != null) ...<Widget>[
          Checkbox(
            value: widget.isSelected,
            onChanged: (_) => widget.onToggleSelect?.call(),
            activeColor: EnhancedDesignSystem.primaryColor,
          ),
          const SizedBox(width: EnhancedDesignSystem.space3),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.rate['serviceName'],
                style: EnhancedDesignSystem.headingSm,
              ),
              const SizedBox(height: EnhancedDesignSystem.space1),
              Row(
                children: [
                  _buildChip(
                    widget.rate['category'],
                    EnhancedDesignSystem.gray100,
                    EnhancedDesignSystem.gray600,
                  ),
                  const SizedBox(width: EnhancedDesignSystem.space2),
                  _buildChip(
                    widget.rate['region'],
                    EnhancedDesignSystem.gray100,
                    EnhancedDesignSystem.gray600,
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildChip(
          widget.rate['status'],
          statusColor.withValues(alpha: 0.1),
          statusColor,
        ),
        if (_isHovered) ...<Widget>[
          const SizedBox(width: EnhancedDesignSystem.space3),
          _buildQuickActions(),
        ]
      ],
    );
  }

  Widget _buildRateInfo() {
    return Container(
      padding: const EdgeInsets.all(EnhancedDesignSystem.space4),
      decoration: BoxDecoration(
        color: EnhancedDesignSystem.gray50,
        borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildRateItem(
              'Base Rate',
              '\$${widget.rate['baseRate'].toStringAsFixed(2)}',
              '/hr',
              EnhancedDesignSystem.successColor,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: EnhancedDesignSystem.borderColor,
          ),
          Expanded(
            child: _buildRateItem(
              'Weekend',
              '\$${widget.rate['weekendRate'].toStringAsFixed(2)}',
              '/hr',
              EnhancedDesignSystem.warningColor,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: EnhancedDesignSystem.borderColor,
          ),
          Expanded(
            child: _buildRateItem(
              'Holiday',
              '\$${widget.rate['publicHolidayRate'].toStringAsFixed(2)}',
              '/hr',
              EnhancedDesignSystem.errorColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRateItem(
      String label, String value, String suffix, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: EnhancedDesignSystem.caption,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: EnhancedDesignSystem.space1),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: EnhancedDesignSystem.headingSm.copyWith(
                  color: color,
                ),
              ),
              TextSpan(
                text: suffix,
                style: EnhancedDesignSystem.bodySm.copyWith(
                  color: EnhancedDesignSystem.gray500,
                ),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Icon(
          Icons.schedule,
          size: 14,
          color: EnhancedDesignSystem.gray400,
        ),
        const SizedBox(width: EnhancedDesignSystem.space1),
        Expanded(
          child: Text(
            'Updated ${widget.rate['lastUpdated']}',
            style: EnhancedDesignSystem.caption,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: EnhancedDesignSystem.space1),
        Text(
          'ID: ${widget.rate['id']}',
          style: EnhancedDesignSystem.caption,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: EnhancedDesignSystem.space2,
        vertical: EnhancedDesignSystem.space1,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusSm),
      ),
      child: Text(
        label,
        style: EnhancedDesignSystem.bodySm.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildActionButton(
          icon: Icons.edit_outlined,
          onTap: widget.onEdit,
          tooltip: 'Edit',
        ),
        const SizedBox(width: EnhancedDesignSystem.space1),
        _buildActionButton(
          icon: Icons.delete_outline,
          onTap: widget.onDelete,
          tooltip: 'Delete',
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    VoidCallback? onTap,
    String? tooltip,
    bool isDestructive = false,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isDestructive
              ? EnhancedDesignSystem.errorColor.withValues(alpha: 0.1)
              : EnhancedDesignSystem.gray100,
          borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusMd),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusMd),
            child: Icon(
              icon,
              size: 16,
              color: isDestructive
                  ? EnhancedDesignSystem.errorColor
                  : EnhancedDesignSystem.gray600,
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return EnhancedDesignSystem.successColor;
      case 'pending':
        return EnhancedDesignSystem.warningColor;
      case 'inactive':
        return EnhancedDesignSystem.errorColor;
      default:
        return EnhancedDesignSystem.gray500;
    }
  }
}

/// Enhanced empty state widget
class EnhancedEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EnhancedEmptyState({
    Key? key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(EnhancedDesignSystem.space12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: EnhancedDesignSystem.gray100,
                borderRadius:
                    BorderRadius.circular(EnhancedDesignSystem.radiusXl),
              ),
              child: Icon(
                icon,
                size: 40,
                color: EnhancedDesignSystem.gray400,
              ),
            ),
            const SizedBox(height: EnhancedDesignSystem.space6),
            Text(
              title,
              style: EnhancedDesignSystem.headingMd.copyWith(
                color: EnhancedDesignSystem.gray600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: EnhancedDesignSystem.space3),
            Text(
              message,
              style: EnhancedDesignSystem.bodyMd.copyWith(
                color: EnhancedDesignSystem.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...<Widget>[
              const SizedBox(height: EnhancedDesignSystem.space6),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: EnhancedDesignSystem.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: EnhancedDesignSystem.space6,
                    vertical: EnhancedDesignSystem.space3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(EnhancedDesignSystem.radiusLg),
                  ),
                ),
                child: Text(actionLabel!),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
