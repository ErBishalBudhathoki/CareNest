import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/holiday/views/add_holiday_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HolidayListView extends ConsumerStatefulWidget {
  final List<dynamic> holidays;
  final bool readonly;

  const HolidayListView({
    super.key, 
    required this.holidays,
    this.readonly = false,
  });

  @override
  _HolidayListViewState createState() => _HolidayListViewState();
}

class _HolidayListViewState extends ConsumerState<HolidayListView> {
  @override
  void initState() {
    super.initState();
    _sortHolidays();
  }

  void _sortHolidays() {
    widget.holidays.sort((a, b) {
      final dateA = _parseDate(a['Date']) ?? DateTime.now();
      final dateB = _parseDate(b['Date']) ?? DateTime.now();
      return dateA.compareTo(dateB);
    });
  }

  void _addHoliday(Map<String, String> holiday) {
    setState(() {
      widget.holidays.add(holiday);
      _sortHolidays();
    });
  }

  void _deleteHoliday(int index) {
    setState(() {
      final holiday = widget.holidays[index];
      debugPrint(holiday['_id']);
      _deleteHolidayItem(holiday['_id']);
      widget.holidays.removeAt(index);
    });
  }

  Future<dynamic> _deleteHolidayItem(String id) async {
    final apiMethod = ref.read(apiMethodProvider);
    return await apiMethod.deleteHolidayItem(id);
  }

  DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateFormat('dd-MM-yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  String _getDaysUntil(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference == 0) {
      return AppLocalizations.of(context)!.today;
    } else if (difference == 1) {
      return 'Tomorrow'; // Consider adding to l10n
    } else if (difference > 1) {
      return 'In $difference days'; // Consider adding to l10n
    } else {
      return AppLocalizations.of(context)!.past;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: BauhausIconButton(
            icon: Icons.arrow_back_ios_new,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          l10n.holidays,
          style: BauhausDesign.getTextTheme(context).headlineMedium,
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: BauhausCard(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(BauhausDesign.space3),
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusMd),
                        ),
                        child: Icon(Icons.calendar_month,
                            color: BauhausDesign.primary, size: 32),
                      ),
                      const SizedBox(width: BauhausDesign.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.holidayList,
                              style: BauhausDesign.getTextTheme(context)
                                  .headlineSmall,
                            ),
                            Text(
                              l10n.holidayListDesc,
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(
                                    color: BauhausDesign.textMuted,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space4,
                        vertical: BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceOffWhite,
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusMd),
                      border: Border.all(
                        color: BauhausDesign.neutral,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.event_available,
                            size: 20, color: BauhausDesign.textDark),
                        const SizedBox(width: BauhausDesign.space3),
                        Text(
                          '${l10n.total}: ${widget.holidays.length}',
                          style: BauhausDesign.getTextTheme(context).labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
          ),

          // Holiday List
          Expanded(
            child: widget.holidays.isEmpty
                ? _buildEmptyState(l10n)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space4),
                    itemCount: widget.holidays.length,
                    itemBuilder: (context, index) {
                      final holiday = widget.holidays[index];
                      final DateTime? holidayDate = _parseDate(holiday['Date']);
                      // Format check for date parsing safety
                      if (holidayDate == null) return const SizedBox.shrink();

                      final bool isUpcoming = holidayDate.isAfter(DateTime.now()
                          .subtract(const Duration(days: 1))); // Include today
                      final bool isToday =
                          DateFormat('dd-MM-yyyy').format(holidayDate) ==
                              DateFormat('dd-MM-yyyy').format(DateTime.now());

                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: BauhausDesign.space3),
                        child: BauhausCard(
                          padding: const EdgeInsets.all(16),
                          child: InkWell(
                            onTap: null, // No action on tap for now
                            child: Row(
                              children: [
                                // Date Circle
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: isToday
                                        ? BauhausDesign.primary
                                        : (isUpcoming
                                            ? BauhausDesign.secondary
                                            : BauhausDesign.neutral),
                                    shape: BoxShape.circle,
                                    boxShadow: isToday
                                        ? [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 4,
                                              offset: const Offset(2, 2),
                                            )
                                          ]
                                        : null,
                                    border: Border.all(
                                        color: BauhausDesign.textDark,
                                        width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('dd').format(holidayDate),
                                        style: BauhausDesign.getTextTheme(
                                                context)
                                            .headlineSmall
                                            ?.copyWith(
                                              color: BauhausDesign.surfaceWhite,
                                              height: 1,
                                            ),
                                      ),
                                      Text(
                                        DateFormat('MMM')
                                            .format(holidayDate)
                                            .toUpperCase(),
                                        style: BauhausDesign.getTextTheme(
                                                context)
                                            .labelSmall
                                            ?.copyWith(
                                              color: BauhausDesign.surfaceWhite,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: BauhausDesign.space4),
                                // Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        holiday['Holiday'] ?? l10n.holiday,
                                        style:
                                            BauhausDesign.getTextTheme(context)
                                                .titleMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${holiday['Date']} • ${holiday['Day']}',
                                        style:
                                            BauhausDesign.getTextTheme(context)
                                                .bodySmall
                                                ?.copyWith(
                                                  color:
                                                      BauhausDesign.textMuted,
                                                ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Status & Delete
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (isUpcoming) ...[
                                      BauhausChip(
                                        text: isToday
                                            ? l10n.today.toUpperCase()
                                            : _getDaysUntil(holidayDate)
                                                .toUpperCase(),
                                        variant: isToday
                                            ? BauhausChipVariant.primary
                                            : BauhausChipVariant.neutral,
                                        size: BauhausChipSize.small,
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                    // Delete Action - Only show if not readonly
                                    if (!widget.readonly)
                                      InkWell(
                                        onTap: () => _deleteHoliday(index),
                                        borderRadius: BorderRadius.circular(
                                            BauhausDesign.radiusFull),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          child: Icon(Icons.delete_outline,
                                              size: 20,
                                              color: BauhausDesign.error),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ).animate(delay: (50 * index).ms).fadeIn().slideX(),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: widget.readonly
          ? null
          : BauhausActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddHolidayScreen(
                      addHoliday: _addHoliday,
                      holidays: widget.holidays,
                    ),
                  ),
                );
              },
              icon: Icons.add,
              text: l10n.addHoliday,
              isFullWidth: false,
            ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return BauhausEmptyState(
      title: 'No Holidays Yet', // Consider adding to l10n
      subtitle: 'Add your first holiday to get started', // Consider adding to l10n
      icon: Icons.calendar_today,
      onAction: widget.readonly
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddHolidayScreen(
                    addHoliday: _addHoliday,
                    holidays: widget.holidays,
                  ),
                ),
              );
            },
      actionLabel: widget.readonly ? null : l10n.addHoliday,
    );
  }
}
