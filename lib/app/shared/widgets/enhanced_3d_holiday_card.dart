import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Enhanced3DHolidayCard extends StatefulWidget {
  final Map<String, dynamic> holiday;
  final int index;
  final VoidCallback onDelete;
  final bool isUpcoming;
  final bool isToday;

  const Enhanced3DHolidayCard({
    super.key,
    required this.holiday,
    required this.index,
    required this.onDelete,
    required this.isUpcoming,
    required this.isToday,
  });

  @override
  State<Enhanced3DHolidayCard> createState() => _Enhanced3DHolidayCardState();
}

class _Enhanced3DHolidayCardState extends State<Enhanced3DHolidayCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pulseController;
  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _elevationAnimation = Tween<double>(
      begin: 2.0,
      end: 12.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.isToday) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pulseController.dispose();
    super.dispose();
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

  DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateFormat('dd-MM-yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  String _getDateDay(String? dateString) {
    if (dateString == null) return '--';
    try {
      final date = DateFormat('dd-MM-yyyy').parse(dateString);
      return DateFormat('dd').format(date);
    } catch (e) {
      return '--';
    }
  }

  String _getDateMonth(String? dateString) {
    if (dateString == null) return '---';
    try {
      final date = DateFormat('dd-MM-yyyy').parse(dateString);
      return DateFormat('MMM').format(date).toUpperCase();
    } catch (e) {
      return '---';
    }
  }

  String _getDaysUntil(DateTime date) {
    final now = DateTime.now();
    final difference =
        date.difference(DateTime(now.year, now.month, now.day)).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 7) return 'In $difference days';
    if (difference < 30) return 'In ${(difference / 7).round()} weeks';
    return 'In ${(difference / 30).round()} months';
  }

  Color _getHolidayColor(ThemeData theme) {
    if (widget.isToday) {
      return const Color(0xFF3B82F6); // Modern SAAS primary blue for today
    } else if (widget.isUpcoming) {
      return const Color(
          0xFF10B981); // Modern SAAS secondary green for upcoming
    } else {
      return const Color(0xFF64748B); // Modern SAAS neutral for past holidays
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final holidayDate = _parseDate(widget.holiday['Date']);
    final holidayColor = _getHolidayColor(theme);

    return AnimatedBuilder(
      animation: Listenable.merge(
          [_scaleAnimation, _elevationAnimation, _pulseAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isToday ? _pulseAnimation.value : _scaleAnimation.value,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Dismissible(
              key: Key('holiday_${widget.index}'),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                widget.onDelete();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.holiday['Holiday']} deleted'),
                    backgroundColor: theme.colorScheme.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0x80EF4444), // Modern SAAS error with opacity
                      Color(0xFFEF4444), // Modern SAAS error
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Delete',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              child: MouseRegion(
                onEnter: (_) => _onHover(true),
                onExit: (_) => _onHover(false),
                child: Material(
                  elevation: _elevationAnimation.value,
                  borderRadius: BorderRadius.circular(16),
                  shadowColor: holidayColor.withValues(alpha: 0.3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          widget.isToday
                              ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                              : widget.isUpcoming
                                  ? const Color(0xFF10B981)
                                      .withValues(alpha: 0.12)
                                  : const Color(0xFF64748B)
                                      .withValues(alpha: 0.12),
                          widget.isToday
                              ? const Color(0xFF3B82F6).withValues(alpha: 0.08)
                              : widget.isUpcoming
                                  ? const Color(0xFF10B981)
                                      .withValues(alpha: 0.06)
                                  : const Color(0xFF64748B)
                                      .withValues(alpha: 0.06),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: widget.isToday
                            ? const Color(0xFF3B82F6).withValues(alpha: 0.4)
                            : widget.isUpcoming
                                ? const Color(0xFF10B981).withValues(alpha: 0.3)
                                : const Color(0xFF64748B)
                                    .withValues(alpha: 0.3),
                        width: widget.isToday ? 2 : 1.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          // Background pattern
                          Positioned(
                            right: -20,
                            top: -20,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    holidayColor.withValues(alpha: 0.2),
                                    holidayColor.withValues(alpha: 0.05),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Main content
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                // 3D Date Circle
                                _build3DDateCircle(theme, holidayColor),
                                const SizedBox(width: 20),
                                // Holiday Details
                                Expanded(
                                  child: _buildHolidayDetails(theme),
                                ),
                                // Removed meaningless status indicator
                              ],
                            ),
                          ),
                          // Shimmer effect for today's holiday
                          if (widget.isToday)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      theme.colorScheme.primary
                                          .withValues(alpha: 0.1),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                    begin: const Alignment(-1.0, -0.3),
                                    end: const Alignment(1.0, 0.3),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _build3DDateCircle(ThemeData theme, Color holidayColor) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            holidayColor,
            Color.lerp(holidayColor, Colors.black, 0.2)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: holidayColor.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              holidayColor.withValues(alpha: 0.9),
              holidayColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getDateDay(widget.holiday['Date']),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: widget.isToday || widget.isUpcoming
                    ? Colors.white
                    : theme.colorScheme.onSurface,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            Text(
              _getDateMonth(widget.holiday['Date']),
              style: theme.textTheme.bodySmall?.copyWith(
                color: (widget.isToday || widget.isUpcoming
                        ? Colors.white
                        : theme.colorScheme.onSurface)
                    .withValues(alpha: 0.9),
                fontWeight: FontWeight.w600,
                fontSize: 11,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHolidayDetails(ThemeData theme) {
    final holidayDate = _parseDate(widget.holiday['Date']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.holiday['Holiday'] ?? 'Unknown Holiday',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.isToday)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF2196F3),
                      const Color(0xFF42A5F5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'TODAY',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 6),
            Text(
              '${widget.holiday['Date']} • ${widget.holiday['Day']}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (widget.isUpcoming && !widget.isToday && holidayDate != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 6),
              Text(
                _getDaysUntil(holidayDate),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        // Holiday type indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _getHolidayColor(theme).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getHolidayColor(theme).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            widget.isToday
                ? 'Current Holiday'
                : widget.isUpcoming
                    ? 'Upcoming'
                    : 'Past Holiday',
            style: theme.textTheme.bodySmall?.copyWith(
              color: _getHolidayColor(theme),
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}