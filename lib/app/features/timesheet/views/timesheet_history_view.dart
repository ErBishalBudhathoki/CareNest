import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/app/features/timesheet/viewmodels/timesheet_viewmodel.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/repositories/timesheet_repository.dart';

// Simple provider for history, fetching last 365 days
final timesheetHistoryProvider = FutureProvider.autoDispose.family<List<TimesheetEntry>, String>((ref, email) async {
  final repository = ref.read(timesheetRepositoryProvider);
  final end = DateTime.now();
  final start = end.subtract(const Duration(days: 365)); // Last year to catch older test data
  debugPrint('TIMESHEET_HISTORY: Fetching from ${start.toIso8601String()} to ${end.toIso8601String()} for $email');
  final result = await repository.fetchTimesheets(email: email, startDate: start, endDate: end);
  debugPrint('TIMESHEET_HISTORY: Found ${result.length} entries');
  return result;
});

class TimesheetHistoryView extends ConsumerWidget {
  final String email;

  const TimesheetHistoryView({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(timesheetHistoryProvider(email));

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'HISTORY',
          style: GoogleFonts.oswald(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: BauhausDesign.textDark),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
           debugPrint('TIMESHEET_HISTORY: Refreshing...');
           return ref.refresh(timesheetHistoryProvider(email).future);
        },
        color: BauhausDesign.primary,
        child: historyAsync.when(
          data: (entries) {
            // Group entries by week
            final weeks = _groupByWeek(entries);
            if (weeks.isEmpty) {
               return Stack(
                 children: [
                   ListView(), // Ensure RefreshIndicator works even when empty
                   Center(
                      child: Text('No history found', style: GoogleFonts.robotoMono(color: BauhausDesign.neutral)),
                   ),
                 ],
               );
            }
            
            return ListView.separated(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              itemCount: weeks.length,
              separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space4),
              itemBuilder: (context, index) {
                final weekStart = weeks.keys.elementAt(index);
                final weekEntries = weeks[weekStart]!;
                final weekEnd = weekStart.add(const Duration(days: 6));
                
                return _buildWeekCard(context, ref, weekStart, weekEnd, weekEntries);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(color: BauhausDesign.primary)),
          error: (e, s) => Stack(
             children: [
                ListView(),
                Center(child: Text('Error: $e', style: GoogleFonts.robotoMono(color: BauhausDesign.error))),
             ],
          ),
        ),
      ),
    );
  }

  // Helper to group entries by Monday of their week
  Map<DateTime, List<TimesheetEntry>> _groupByWeek(List<TimesheetEntry> entries) {
    final Map<DateTime, List<TimesheetEntry>> groups = {};
    for (var entry in entries) {
      final date = entry.workDate ?? (entry.shiftDate != null ? DateTime.tryParse(entry.shiftDate!) : null);
      if (date != null) {
        // Find Monday
        final monday = date.subtract(Duration(days: date.weekday - 1));
        final key = DateTime(monday.year, monday.month, monday.day);
        if (!groups.containsKey(key)) {
            groups[key] = [];
        }
        groups[key]!.add(entry);
      }
    }
    // Sort keys descending
    final sortedKeys = groups.keys.toList()..sort((a, b) => b.compareTo(a));
    return Map.fromEntries(sortedKeys.map((k) => MapEntry(k, groups[k]!)));
  }

  Widget _buildWeekCard(BuildContext context, WidgetRef ref, DateTime start, DateTime end, List<TimesheetEntry> entries) {
     final dateFormat = DateFormat('MMM dd');
     // Calculate total hours
     int totalSeconds = 0;
     for (var e in entries) {
         if (e.timeWorked != null) {
             final parts = e.timeWorked!.split(':');
             if(parts.length == 3) totalSeconds += int.parse(parts[0])*3600 + int.parse(parts[1])*60 + int.parse(parts[2]);
         }
     }
     final h = totalSeconds ~/ 3600;
     final m = (totalSeconds % 3600) ~/ 60;
     final totalStr = '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

     return Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: BoxDecoration(
           color: BauhausDesign.surfaceLight,
           border: Border.all(color: BauhausDesign.textDark, width: 2),
           boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Text(
                          '${dateFormat.format(start)} - ${dateFormat.format(end)}',
                          style: GoogleFonts.oswald(fontSize: 18, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: BauhausDesign.primary,
                          child: Text(
                              totalStr,
                              style: GoogleFonts.jetBrainsMono(fontSize: 14, fontWeight: FontWeight.bold, color: BauhausDesign.surfaceLight),
                          ),
                      )
                  ],
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                  '${entries.length} Shifts',
                  style: GoogleFonts.robotoMono(fontSize: 12, color: BauhausDesign.neutral),
              ),
              const SizedBox(height: BauhausDesign.space3),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                       onPressed: () {
                           // Logic to navigate to TimesheetView focused on this week
                           debugPrint('TIMESHEET_DEBUG: View Details tapped for week starting $start');
                           ref.read(timesheetDateProvider.notifier).state = start;
                           debugPrint('TIMESHEET_DEBUG: Provider state updated. Popping context.');
                           Navigator.pop(context);
                      },
                      child: Text('VIEW DETAILS',  style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, color: BauhausDesign.primary)),
                  ),
              )
           ],
        ),
     );
  }
}
