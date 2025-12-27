import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';

class ModernHolidayCard extends StatefulWidget {
  final Map<String, dynamic> holiday;
  final int index;
  final VoidCallback onDelete;
  final bool isUpcoming;
  final bool isToday;

  const ModernHolidayCard({
    super.key,
    required this.holiday,
    required this.index,
    required this.onDelete,
    required this.isUpcoming,
    required this.isToday,
  });

  @override
  State<ModernHolidayCard> createState() => _ModernHolidayCardState();
}

class _ModernHolidayCardState extends State<ModernHolidayCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;
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

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
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

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    if (widget.isToday) {
      _pulseController.repeat(reverse: true);
      _shimmerController.repeat();
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
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
    final date = _parseDate(dateString);
    return date != null ? DateFormat('dd').format(date) : '??';
  }

  String _getDateMonth(String? dateString) {
    final date = _parseDate(dateString);
    return date != null ? DateFormat('MMM').format(date).toUpperCase() : '???';
  }

  String _getDaysUntil(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference > 1) {
      return 'In $difference days';
    } else {
      return 'Past holiday';
    }
  }

  Color _getHolidayColor() {
    if (widget.isToday) return ModernInvoiceDesign.primary;
    if (widget.isUpcoming) return ModernInvoiceDesign.secondary;
    return ModernInvoiceDesign.accent;
  }

  LinearGradient _getStatusGradient(bool isToday, bool isUpcoming) {
    if (isToday) {
      return ModernInvoiceDesign.primaryGradient;
    } else if (isUpcoming) {
      return ModernInvoiceDesign.successGradient;
    } else {
      return ModernInvoiceDesign.warningGradient;
    }
  }

  Color _getStatusColor(bool isToday, bool isUpcoming) {
    if (isToday) {
      return ModernInvoiceDesign.primary;
    } else if (isUpcoming) {
      return ModernInvoiceDesign.secondary;
    } else {
      return ModernInvoiceDesign.accent;
    }
  }

  LinearGradient _getCardBackgroundGradient(bool isToday, bool isUpcoming) {
    if (isToday) {
      return const LinearGradient(
        colors: [
          Color(0xFFF8FAFC),
          Color(0xFFEEF2FF),
          Color(0xFFF1F5F9),
        ],
        stops: [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (isUpcoming) {
      return const LinearGradient(
        colors: [
          Color(0xFFF0FDFA),
          Color(0xFFECFDF5),
          Color(0xFFF8FAFC),
        ],
        stops: [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [
          Color(0xFFF0FDFA),
          Color(0xFFCCFBF1),
          Color(0xFFF8FAFC),
        ],
        stops: [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  List<BoxShadow> _getCardShadow(bool isToday, bool isUpcoming) {
    if (isToday) {
      return ModernInvoiceDesign.shadowLg;
    } else if (isUpcoming) {
      return ModernInvoiceDesign.shadowMd;
    } else {
      return ModernInvoiceDesign.shadowSm;
    }
  }

  String _getStatusText(bool isToday, bool isUpcoming) {
    if (isToday) {
      return 'Today';
    } else if (isUpcoming) {
      return 'Upcoming';
    } else {
      return 'Past Holiday';
    }
  }

  LinearGradient _getCardGradient() {
    if (widget.isToday) {
      return const LinearGradient(
        colors: [
          Color(0x20FFFFFF),
          Color(0x10FFFFFF),
          Color(0x05FFFFFF),
        ],
        stops: [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return ModernInvoiceDesign.primaryGradient;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _scaleAnimation,
        _elevationAnimation,
        _pulseAnimation,
        _shimmerAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isToday ? _pulseAnimation.value : _scaleAnimation.value,
          child: Container(
            margin: const EdgeInsets.only(bottom: ModernInvoiceDesign.space4),
            child: Dismissible(
              key: Key('holiday_${widget.index}'),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                widget.onDelete();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: ModernInvoiceDesign.space2),
                        Text('${widget.holiday['Holiday']} deleted'),
                      ],
                    ),
                    backgroundColor: ModernInvoiceDesign.error,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                    ),
                  ),
                );
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding:
                    const EdgeInsets.only(right: ModernInvoiceDesign.space5),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF6B6B),
                      Color(0xFFEF4444),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space1),
                    Text(
                      'Delete',
                      style: ModernInvoiceDesign.labelMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              child: MouseRegion(
                onEnter: (_) {
                  setState(() => _isHovered = true);
                  _hoverController.forward();
                },
                onExit: (_) {
                  setState(() => _isHovered = false);
                  _hoverController.reverse();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                    boxShadow: [
                      // Primary glow shadow
                      BoxShadow(
                        color: _getHolidayColor().withValues(alpha: 0.25),
                        blurRadius: 30 + _elevationAnimation.value * 2,
                        offset: Offset(0, 12 + _elevationAnimation.value * 1.5),
                        spreadRadius: -5,
                      ),
                      // Secondary depth shadow
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20 + _elevationAnimation.value,
                        offset: Offset(0, 8 + _elevationAnimation.value),
                        spreadRadius: -3,
                      ),
                      // Subtle inner shadow effect
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withValues(alpha: 0.95),
                              Colors.white.withValues(alpha: 0.9),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _getHolidayColor().withValues(alpha: 0.1),
                            width: 1.5,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Shimmer effect for today's holiday
                            if (widget.isToday)
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          _getHolidayColor()
                                              .withValues(alpha: 0.1),
                                          Colors.transparent,
                                        ],
                                        stops: const [0.0, 0.5, 1.0],
                                        begin: Alignment(
                                          _shimmerAnimation.value - 1,
                                          -1,
                                        ),
                                        end: Alignment(
                                          _shimmerAnimation.value,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            // Main content
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  _build3DDateCircle(),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _build3DHolidayDetails(),
                                  ),
                                  const SizedBox(width: 12),
                                  _build3DStatusIndicator(),
                                ],
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
          ),
        );
      },
    );
  }

  Widget _buildDateCircle() {
    return _build3DDateCircle();
  }

  Widget _build3DDateCircle() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          // Main shadow for depth
          BoxShadow(
            color: _getHolidayColor().withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -2,
          ),
          // Inner highlight
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 4,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isToday
                ? [
                    ModernInvoiceDesign.primary,
                    ModernInvoiceDesign.primary.withValues(alpha: 0.8),
                    ModernInvoiceDesign.primary.withValues(alpha: 0.9),
                  ]
                : widget.isUpcoming
                    ? [
                        ModernInvoiceDesign.secondary,
                        ModernInvoiceDesign.secondary.withValues(alpha: 0.8),
                        ModernInvoiceDesign.secondary.withValues(alpha: 0.9),
                      ]
                    : [
                        ModernInvoiceDesign.accent,
                        ModernInvoiceDesign.accent.withValues(alpha: 0.8),
                        ModernInvoiceDesign.accent.withValues(alpha: 0.9),
                      ],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getDateDay(widget.holiday['Date']),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            Text(
              _getDateMonth(widget.holiday['Date']),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 0.8,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    offset: const Offset(0, 0.5),
                    blurRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHolidayDetails() {
    return _build3DHolidayDetails();
  }

  Widget _buildHolidayDetailsImproved() {
    return _build3DHolidayDetails();
  }

  Widget _build3DHolidayDetails() {
    final holidayDate = _parseDate(widget.holiday['Date']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.holiday['Holiday'] ?? 'Holiday',
          style: ModernInvoiceDesign.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: ModernInvoiceDesign.textPrimary,
            height: 1.2,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 14,
              color: ModernInvoiceDesign.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              '${widget.holiday['Date']} • ${widget.holiday['Day']}',
              style: ModernInvoiceDesign.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: ModernInvoiceDesign.textSecondary,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        if (widget.isUpcoming && !widget.isToday && holidayDate != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 14,
                color: ModernInvoiceDesign.secondary,
              ),
              const SizedBox(width: 4),
              Text(
                _getDaysUntil(holidayDate),
                style: ModernInvoiceDesign.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ModernInvoiceDesign.secondary,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildStatusIndicator() {
    return _build3DStatusIndicator();
  }

  Widget _build3DStatusIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getHolidayColor().withValues(alpha: 0.15),
            _getHolidayColor().withValues(alpha: 0.08),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getHolidayColor().withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _getHolidayColor().withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 2,
            offset: const Offset(0, -1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.isToday
                ? Icons.star_rounded
                : widget.isUpcoming
                    ? Icons.schedule_rounded
                    : Icons.check_circle_rounded,
            color: _getHolidayColor(),
            size: 16,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 0.5),
                blurRadius: 1,
              ),
            ],
          ),
          const SizedBox(width: 6),
          Text(
            widget.isToday
                ? 'Today'
                : widget.isUpcoming
                    ? 'Upcoming'
                    : 'Past',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _getHolidayColor(),
              letterSpacing: 0.3,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 0.5),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}