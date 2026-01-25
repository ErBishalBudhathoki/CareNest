import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class TimesheetView extends StatefulWidget {
  final String email;

  const TimesheetView({super.key, required this.email});

  @override
  State<TimesheetView> createState() => _TimesheetViewState();
}

class _TimesheetViewState extends State<TimesheetView> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 14));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.timesheetTitle,
          style: BauhausDesign.getTextTheme(context).titleLarge,
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_rounded),
            onPressed: () {
              // Add menu options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Range Section
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space6,
              vertical: BauhausDesign.space4,
            ),
            color: BauhausDesign.surfaceWhite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDateChip(DateFormat('MM/dd/yyyy').format(startDate)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space3),
                  child: Text(
                    AppLocalizations.of(context)!.toLabel,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                        ),
                  ),
                ),
                _buildDateChip(DateFormat('MM/dd/yyyy').format(endDate)),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              child: Column(
                children: [
                  // Time Summary
                  BauhausCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTimeColumn(
                            AppLocalizations.of(context)!.regularLabel, '8:00'),
                        _buildTimeColumn(
                            AppLocalizations.of(context)!.otLabel, '--'),
                        _buildTimeColumn(
                            AppLocalizations.of(context)!.totalLabel, '8:00'),
                        _buildTimeColumn(
                            AppLocalizations.of(context)!.absenceLabel, '--'),
                      ],
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space4),

                  // Requests Card
                  BauhausActionTile(
                    title: AppLocalizations.of(context)!.requestsLabel,
                    icon: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: BauhausDesign.warning,
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusPill),
                      ),
                      child: Text(
                        '1',
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    onTap: () {
                      // Navigate to requests
                    },
                    showChevron: true,
                  ),

                  const SizedBox(height: BauhausDesign.space2),

                  // Week Total Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.weekTotalLabel('8:00'),
                          style: BauhausDesign.getTextTheme(context)
                              .labelLarge
                              ?.copyWith(
                                color: BauhausDesign.textMuted,
                              ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Show more details
                          },
                          child: Text(
                            AppLocalizations.of(context)!.moreLabel,
                            style: BauhausDesign.getTextTheme(context)
                                .labelLarge
                                ?.copyWith(
                                  color: BauhausDesign.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: BauhausDesign.space2),

                  // Daily Time List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: BauhausDesign.space3),
                    itemBuilder: (context, index) {
                      final date =
                          DateTime.now().subtract(Duration(days: index));
                      return _buildDayTimeCard(date);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: BauhausDesign.backgroundLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusPill),
        border: Border.all(color: BauhausDesign.neutral),
      ),
      child: Text(
        date,
        style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildDayTimeCard(DateTime date) {
    final isToday = date.day == DateTime.now().day;
    final dayFormat = DateFormat('dd');
    final weekdayFormat = DateFormat('EEE');

    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Row(
        children: [
          // Date Column
          Container(
            width: 50,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: isToday ? BauhausDesign.primary : Colors.transparent,
                  width: 4,
                ),
              ),
            ),
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              children: [
                Text(
                  dayFormat.format(date),
                  style: BauhausDesign.getTextTheme(context)
                      .headlineSmall
                      ?.copyWith(
                        color: isToday
                            ? BauhausDesign.primary
                            : BauhausDesign.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  weekdayFormat.format(date),
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: isToday
                                ? BauhausDesign.primary
                                : BauhausDesign.textMuted,
                          ),
                ),
              ],
            ),
          ),
          const SizedBox(width: BauhausDesign.space4),
          // Time Details
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeDetail(AppLocalizations.of(context)!.regularLabel,
                    isToday ? '8:00' : '--'),
                _buildTimeDetail(AppLocalizations.of(context)!.otLabel, '--'),
                _buildTimeDetail(AppLocalizations.of(context)!.totalLabel,
                    isToday ? '8:00' : '--'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDetail(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: time == '--'
                    ? BauhausDesign.primary
                    : BauhausDesign.textDark,
              ),
        ),
      ],
    );
  }
}
