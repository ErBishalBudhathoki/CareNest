import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
    this.isLoading = false,
  });

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
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withOpacity(0.1)
                  : const Color(0xFFE0E0E0).withOpacity(0.1),
              width: _isHovered ? 2 : 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
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
                color: widget.color.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(8.0),
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
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 10,
                  color: const Color(0xFFFAFAFA),
                ),
              ),
          ],
        ),

        // Main content area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Value
                Text(
                  widget.value,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600).copyWith(
                    color: const Color(0xFF171717),
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
                  style: const TextStyle(fontSize: 14).copyWith(
                    color: const Color(0xFF404040),
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
              style: const TextStyle(fontSize: 12).copyWith(
                color: const Color(0xFF757575),
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
                color: const Color(0xFFE5E5E5),
                borderRadius:
                    BorderRadius.circular(8.0),
              ),
            ),
            const Spacer(),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          width: 60,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5E5),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          width: 80,
          height: 12,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5E5),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: Colors.white.withOpacity(0.1));
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
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.onFilterTap,
    this.onAddTap,
    this.activeFilters = const [],
  });

  @override
  State<EnhancedSearchBar> createState() => _EnhancedSearchBarState();
}

class _EnhancedSearchBarState extends State<EnhancedSearchBar> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE0E0E0),
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
                    color: const Color(0xFFFAFAFA),
                    borderRadius:
                        BorderRadius.circular(12.0),
                    border: Border.all(
                      color: _isFocused
                          ? const Color(0xFF667EEA)
                          : const Color(0xFFE0E0E0),
                      width: _isFocused ? 2 : 1,
                    ),
                  ),
                  child: TextField(
                    controller: widget.controller,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(fontSize: 14).copyWith(
                        color: const Color(0xFFA3A3A3),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: const Color(0xFFA3A3A3),
                        size: 20,
                      ),
                      suffixIcon: widget.controller.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: const Color(0xFFA3A3A3),
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
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                    onTap: () => setState(() => _isFocused = true),
                    onTapOutside: (_) => setState(() => _isFocused = false),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              _buildActionButton(
                icon: Icons.tune,
                onTap: widget.onFilterTap,
                badge: widget.activeFilters.length,
              ),
              const SizedBox(width: 8.0),
              _buildActionButton(
                icon: Icons.add,
                onTap: widget.onAddTap,
                isPrimary: true,
              ),
            ],
          ),
          if (widget.activeFilters.isNotEmpty) ...<Widget>[
            const SizedBox(height: 16.0),
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
                ? const Color(0xFF667EEA)
                : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: isPrimary
                ? null
                : Border.all(color: const Color(0xFFE0E0E0)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius:
                  BorderRadius.circular(12.0),
              child: Icon(
                icon,
                color: isPrimary ? Colors.white : const Color(0xFF757575),
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
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                badge.toString(),
                style: const TextStyle(fontSize: 12).copyWith(
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
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.activeFilters.map((filter) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF667EEA).withOpacity(0.1),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: const Color(0xFF667EEA).withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                filter,
                style: const TextStyle(fontSize: 12).copyWith(
                  color: const Color(0xFF667EEA),
                ),
              ),
              const SizedBox(width: 4.0),
              GestureDetector(
                onTap: () {
                  // Remove filter logic would go here
                },
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: const Color(0xFF667EEA),
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
    super.key,
    required this.rate,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleSelect,
  });

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
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: widget.isSelected
                ? const Color(0xFF667EEA)
                : _isHovered
                    ? const Color(0xFFD4D4D4)
                    : const Color(0xFFE0E0E0),
            width: widget.isSelected ? 2 : 1,
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]
              : [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(statusColor),
                  const SizedBox(height: 16.0),
                  _buildRateInfo(),
                  const SizedBox(height: 16.0),
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
            activeColor: const Color(0xFF667EEA),
          ),
          const SizedBox(width: 12.0),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.rate['serviceName'],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  _buildChip(
                    widget.rate['category'],
                    const Color(0xFFF5F5F5),
                    const Color(0xFF757575),
                  ),
                  const SizedBox(width: 8.0),
                  _buildChip(
                    widget.rate['region'],
                    const Color(0xFFF5F5F5),
                    const Color(0xFF757575),
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildChip(
          widget.rate['status'],
          statusColor.withOpacity(0.1),
          statusColor,
        ),
        if (_isHovered) ...<Widget>[
          const SizedBox(width: 12.0),
          _buildQuickActions(),
        ]
      ],
    );
  }

  Widget _buildRateInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildRateItem(
              'Base Rate',
              '\$${widget.rate['baseRate'].toStringAsFixed(2)}',
              '/hr',
              Colors.green,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: const Color(0xFFE0E0E0),
          ),
          Expanded(
            child: _buildRateItem(
              'Weekend',
              '\$${widget.rate['weekendRate'].toStringAsFixed(2)}',
              '/hr',
              Colors.orange,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: const Color(0xFFE0E0E0),
          ),
          Expanded(
            child: _buildRateItem(
              'Holiday',
              '\$${widget.rate['publicHolidayRate'].toStringAsFixed(2)}',
              '/hr',
              Colors.red,
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
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 4.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600).copyWith(
                  color: color,
                ),
              ),
              TextSpan(
                text: suffix,
                style: const TextStyle(fontSize: 12).copyWith(
                  color: const Color(0xFFFAFAFA),
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
          color: const Color(0xFFA3A3A3),
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: Text(
            'Updated ${widget.rate['lastUpdated']}',
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          'ID: ${widget.rate['id']}',
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color surfaceColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12).copyWith(
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
        const SizedBox(width: 4.0),
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
              ? Colors.red.withOpacity(0.1)
              : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.0),
            child: Icon(
              icon,
              size: 16,
              color: isDestructive
                  ? Colors.red
                  : const Color(0xFF757575),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'inactive':
        return Colors.red;
      default:
        return const Color(0xFFFAFAFA);
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
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius:
                    BorderRadius.circular(16.0),
              ),
              child: Icon(
                icon,
                size: 40,
                color: const Color(0xFFA3A3A3),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                color: const Color(0xFF757575),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),
            Text(
              message,
              style: const TextStyle(fontSize: 14).copyWith(
                color: const Color(0xFFFAFAFA),
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...<Widget>[
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0),
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
