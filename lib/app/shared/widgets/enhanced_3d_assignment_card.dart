import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';

class Enhanced3DAssignmentCard extends StatefulWidget {
  final Map<String, dynamic> assignment;
  final VoidCallback onEdit;
  final String? employeeName;
  final String? clientName;

  const Enhanced3DAssignmentCard({
    Key? key,
    required this.assignment,
    required this.onEdit,
    this.employeeName,
    this.clientName,
  }) : super(key: key);

  @override
  State<Enhanced3DAssignmentCard> createState() =>
      _Enhanced3DAssignmentCardState();
}

class _Enhanced3DAssignmentCardState extends State<Enhanced3DAssignmentCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _chartController;
  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _chartAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _chartController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _elevationAnimation = Tween<double>(begin: 4, end: 12).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
    _chartAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _chartController, curve: Curves.elasticOut),
    );

    _chartController.forward();
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _chartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleArray = widget.assignment['schedule'] ?? [];
    final totalHours = _calculateTotalHours();
    final shiftsCount = scheduleArray.length;
    final weeklyData = _generateWeeklyData();

    return AnimatedBuilder(
      animation: Listenable.merge([_hoverController, _chartController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 2),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: _elevationAnimation.value * 2,
                    offset: Offset(0, _elevationAnimation.value),
                  ),
                ],
                border: Border.all(
                  color: Colors.blue.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.blue.withValues(alpha: 0.05),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Main content
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 20),
                          _buildStatsRow(totalHours, shiftsCount),
                          const SizedBox(height: 24),
                          _buildWeeklyChart(weeklyData),
                          const SizedBox(height: 20),
                          _buildShiftPreview(),
                          const SizedBox(height: 16),
                          _buildFooter(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // 3D Avatar
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade400,
                Colors.blue.shade600,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Iconsax.user,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.employeeName ??
                    _getDisplayName(widget.assignment['userEmail'] ?? ''),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Iconsax.user_tag,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Client: ${widget.clientName ?? _getDisplayName(widget.assignment['clientEmail'] ?? '')}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // 3D Edit Button
        GestureDetector(
          onTap: widget.onEdit,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.shade400,
                  Colors.orange.shade600,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Iconsax.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(double totalHours, int shiftsCount) {
    return Row(
      children: [
        Expanded(
          child: _build3DStatCard(
            icon: Iconsax.clock,
            label: 'Total Hours',
            value: '${totalHours.toStringAsFixed(1)}h',
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _build3DStatCard(
            icon: Iconsax.calendar,
            label: 'Shifts',
            value: shiftsCount.toString(),
            color: Colors.purple,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _build3DStatCard(
            icon: Iconsax.chart_success,
            label: 'Avg/Day',
            value:
                '${(totalHours / math.max(shiftsCount, 1)).toStringAsFixed(1)}h',
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _build3DStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.1),
            color.withValues(alpha: 0.05),
          ],
        ),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.8),
                  color,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.lerp(color, Colors.black, 0.3)!,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(List<FlSpot> data) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.indigo.shade50,
          ],
        ),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.chart_21,
                size: 16,
                color: Colors.blue.shade600,
              ),
              const SizedBox(width: 8),
              Text(
                'Weekly Hours Distribution',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1565C0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Transform.scale(
              scale: _chartAnimation.value,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data,
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade400,
                          Colors.indigo.shade600,
                        ],
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.blue.shade600,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.withValues(alpha: 0.3),
                            Colors.blue.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                  ],
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftPreview() {
    final scheduleArray = widget.assignment['schedule'] ?? [];
    final previewCount = math.min(3, scheduleArray.length as int);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Iconsax.calendar_2,
              size: 16,
              color: Colors.grey.shade700,
            ),
            const SizedBox(width: 8),
            Text(
              'Upcoming Shifts',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(previewCount, (index) {
          final shift = scheduleArray[index];
          return _buildShiftItem(shift, index);
        }),
        if (scheduleArray.length > 3)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '+${scheduleArray.length - 3} more shifts',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildShiftItem(Map<String, dynamic> shift, int index) {
    final date = shift['date'] ?? '';
    final startTime = shift['startTime'] ?? '';
    final endTime = shift['endTime'] ?? '';
    final isHighIntensity = shift['highIntensity'] as bool? ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isHighIntensity ? Colors.red.shade400 : Colors.green.shade400,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatShiftDate(date),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  '$startTime - $endTime',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          if (isHighIntensity)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.red.shade50,
              ),
              child: Text(
                'High',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    final createdAt = widget.assignment['createdAt'] ?? '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Iconsax.calendar_add,
              size: 12,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 4),
            Text(
              'Created ${_formatDate(createdAt)}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade50,
                Colors.indigo.shade50,
              ],
            ),
          ),
          child: Text(
            'Active Assignment',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1565C0),
            ),
          ),
        ),
      ],
    );
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

  double _calculateTotalHours() {
    final scheduleArray = widget.assignment['schedule'] ?? [];
    double totalHours = 0.0;

    for (final shift in scheduleArray) {
      final startTime = shift['startTime']?.toString() ?? '';
      final endTime = shift['endTime']?.toString() ?? '';
      final breakTime = shift['break']?.toString() ?? '';
      totalHours += _calculateShiftHours(startTime, endTime, breakTime);
    }

    return totalHours;
  }

  double _calculateShiftHours(
      String startTime, String endTime, String breakTime) {
    try {
      final start = _parseTime(startTime);
      final end = _parseTime(endTime);
      final breakHours = _parseBreakTime(breakTime);

      if (start != null && end != null) {
        double duration = end.difference(start).inMinutes / 60.0;
        if (duration < 0) duration += 24;
        return (duration - breakHours).clamp(0.0, 24.0);
      }
    } catch (e) {
      debugPrint('Error calculating shift hours: $e');
    }
    return 0.0;
  }

  DateTime? _parseTime(String timeString) {
    if (timeString.isEmpty) return null;
    try {
      final now = DateTime.now();
      if (timeString.toUpperCase().contains('AM') ||
          timeString.toUpperCase().contains('PM')) {
        final format = DateFormat('h:mm a');
        final time = format.parse(timeString.trim());
        return DateTime(now.year, now.month, now.day, time.hour, time.minute);
      }
      if (timeString.contains(':')) {
        final parts = timeString.split(':');
        if (parts.length >= 2) {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          return DateTime(now.year, now.month, now.day, hour, minute);
        }
      }
    } catch (e) {
      debugPrint('Error parsing time "$timeString": $e');
    }
    return null;
  }

  double _parseBreakTime(String breakString) {
    if (breakString.isEmpty) return 0.0;
    final breakLower = breakString.toLowerCase().trim();
    if (breakLower == 'no' || breakLower == 'none') {
      return 0.0;
    }
    if (breakLower == 'yes') {
      return 0.5;
    }
    try {
      return double.parse(breakString);
    } catch (e) {
      debugPrint('Error parsing break time "$breakString": $e');
      return 0.0;
    }
  }

  List<FlSpot> _generateWeeklyData() {
    final scheduleArray = widget.assignment['schedule'] ?? [];
    final weeklyHours = List<double>.filled(7, 0.0);

    for (final shift in scheduleArray) {
      final dateStr = shift['date']?.toString() ?? '';
      if (dateStr.isNotEmpty) {
        try {
          final date = DateTime.parse(dateStr);
          final dayOfWeek = date.weekday - 1; // 0-6 for Mon-Sun
          final startTime = shift['startTime']?.toString() ?? '';
          final endTime = shift['endTime']?.toString() ?? '';
          final breakTime = shift['break']?.toString() ?? '';
          final hours = _calculateShiftHours(startTime, endTime, breakTime);
          if (dayOfWeek >= 0 && dayOfWeek < 7) {
            weeklyHours[dayOfWeek] += hours;
          }
        } catch (e) {
          debugPrint('Error parsing date: $e');
        }
      }
    }

    return weeklyHours.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();
  }

  String _getDisplayName(String email) {
    if (email.isEmpty) return 'Unknown';
    final parts = email.split('@');
    if (parts.isNotEmpty) {
      return parts[0].replaceAll('.', ' ').replaceAll('_', ' ');
    }
    return email;
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _formatShiftDate(String dateString) {
    if (dateString.isEmpty) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
