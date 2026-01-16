import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BauhausScheduleList extends StatelessWidget {
  final List<Map<String, dynamic>> schedules;

  const BauhausScheduleList({
    super.key,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    if (schedules.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border.all(color: BauhausDesign.neutral.withOpacity(0.5)),
        ),
        child: Center(
          child: Text(
            "NO SCHEDULED SHIFTS",
            style: GoogleFonts.oswald(
              fontSize: 16,
              color: BauhausDesign.neutral,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: schedules.map((schedule) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            border: Border.all(color: BauhausDesign.textDark, width: 2),
            boxShadow: const [
              BoxShadow(
                color: BauhausDesign.textDark,
                offset: Offset(4, 4),
                blurRadius: 0,
              )
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left Color Strip (Date Box)
                Container(
                  width: 80,
                  color: BauhausDesign.secondary, // Indigo strip
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _extractDay(schedule['date']),
                        style: GoogleFonts.oswald(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.surfaceLight,
                        ),
                      ),
                      Text(
                        _extractMonth(schedule['date']),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              BauhausDesign.surfaceLight.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.access_time_filled,
                                size: 16, color: BauhausDesign.textDark),
                            const SizedBox(width: 8),
                            Text(
                              "${schedule['startTime'] ?? 'N/A'} - ${schedule['endTime'] ?? 'N/A'}",
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.textDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Break info if exists
                        if (schedule['break'] != null &&
                            schedule['break'].toString().isNotEmpty)
                          Row(
                            children: [
                              const Icon(Icons.coffee,
                                  size: 14, color: BauhausDesign.neutral),
                              const SizedBox(width: 8),
                              Text(
                                "Break: ${schedule['break']}",
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: BauhausDesign.neutral,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _extractDay(dynamic dateStr) {
    if (dateStr == null) return "--";
    try {
      // Handle "YYYY-MM-DD" or "DD/MM/YYYY" or whatever comes in
      // For robustness, try parsing to DateTime if possible, otherwise crude string logic
      DateTime? dt = _parseDate(dateStr.toString());
      if (dt != null) {
        return dt.day.toString().padLeft(2, '0');
      }
      return dateStr.toString().split(RegExp(r'[-/]')).last; // Fallback
    } catch (e) {
      return "--";
    }
  }

  String _extractMonth(dynamic dateStr) {
    if (dateStr == null) return "---";
    try {
      DateTime? dt = _parseDate(dateStr.toString());
      if (dt != null) {
        return DateFormat('MMM').format(dt).toUpperCase();
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  DateTime? _parseDate(String dateStr) {
    // Common formats
    try {
      return DateTime.parse(dateStr);
    } catch (_) {}

    try {
      // DD/MM/YYYY
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        return DateTime(
            int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
    } catch (_) {}

    return null;
  }
}
