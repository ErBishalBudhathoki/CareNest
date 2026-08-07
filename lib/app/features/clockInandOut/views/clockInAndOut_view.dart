import 'package:carenest/app/features/clockInandOut/providers/today_work_hours_provider.dart';
import 'package:carenest/app/features/worker/viewmodels/worker_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/views/requests_view.dart';
import 'package:carenest/app/features/timesheet/views/timesheet_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:intl/intl.dart';

class ClockInAndOutView extends ConsumerStatefulWidget {
  final String email;

  const ClockInAndOutView({super.key, required this.email});

  @override
  ConsumerState<ClockInAndOutView> createState() => _ClockInAndOutViewState();
}

class _ClockInAndOutViewState extends ConsumerState<ClockInAndOutView> {
  late final PageController _pageController;
  int _currentDayOffset = 0;

  DateTime get _selectedDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + _currentDayOffset);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 1;
      final offset = page - 1;
      if (offset != _currentDayOffset) {
        setState(() => _currentDayOffset = offset);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                BauhausDesign.space3,
                BauhausDesign.space2,
                0,
                0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BauhausIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () => Navigator.pop(context),
                  variant: BauhausActionVariant.neutral,
                  isSmall: true,
                ),
              ),
            ),
            _buildTotalHoursHero(),
            const SizedBox(height: BauhausDesign.space2),
            _buildDayNavigation(),
            const SizedBox(height: BauhausDesign.space3),
            Expanded(child: _buildShiftCards()),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                BauhausDesign.space4,
                BauhausDesign.space3,
                BauhausDesign.space4,
                BauhausDesign.space6,
              ),
              child: _buildActionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalHoursHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space2,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final hoursAsync = ref.watch(todayWorkHoursProvider(widget.email));
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TOTAL TODAY',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                hoursAsync.when(
                  data: (hours) => hours.toStringAsFixed(1),
                  loading: () => '--',
                  error: (_, _) => '--',
                ),
                style: BauhausDesign.getTextTheme(context).displayLarge
                    ?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: BauhausDesign.primary,
                      fontSize: 64,
                      height: 1.0,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space1),
              Text(
                'HOURS WORKED',
                style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: BauhausDesign.textDark,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Container(width: 40, height: 3, color: BauhausDesign.neutral),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDayNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BauhausIconButton(
            icon: Icons.chevron_left,
            onPressed: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
          const SizedBox(width: BauhausDesign.space4),
          Text(
            DateFormat('EEE dd MMM').format(_selectedDate).toUpperCase(),
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: BauhausDesign.textDark,
            ),
          ),
          const SizedBox(width: BauhausDesign.space4),
          BauhausIconButton(
            icon: Icons.chevron_right,
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCards() {
    return Consumer(
      builder: (context, ref, child) {
        final dashboardAsync = ref.watch(workerDashboardViewModelProvider);
        return dashboardAsync.when(
          loading: () =>
              const BauhausLoadingState(message: 'Loading shifts...'),
          error: (error, _) => BauhausErrorState(
            message: error.toString(),
            onRetry: () =>
                ref.read(workerDashboardViewModelProvider.notifier).refresh(),
          ),
          data: (dashboard) {
            return PageView(
              controller: _pageController,
              children: [
                _buildDayShiftList(dashboard.todayShifts, -1),
                _buildDayShiftList(dashboard.todayShifts, 0),
                _buildDayShiftList(dashboard.todayShifts, 1),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDayShiftList(List<dynamic> allShifts, int dayOffset) {
    final targetDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + dayOffset,
    );
    final shifts = allShifts.where((shift) {
      final shiftDate = shift.startTime is DateTime
          ? shift.startTime as DateTime
          : DateTime.tryParse(shift.startTime?.toString() ?? '');
      if (shiftDate == null) return dayOffset == 0;
      return shiftDate.year == targetDate.year &&
          shiftDate.month == targetDate.month &&
          shiftDate.day == targetDate.day;
    }).toList();

    if (shifts.isEmpty) {
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: const BauhausEmptyState(
              icon: Icons.event_busy,
              title: 'No shifts scheduled',
              message: 'No shifts found for this date.',
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      itemCount: shifts.length,
      separatorBuilder: (_, _) => const SizedBox(height: BauhausDesign.space2),
      itemBuilder: (context, index) => _buildShiftCard(shifts[index]),
    );
  }

  Widget _buildShiftCard(dynamic shift) {
    final startTime = _formatShiftTime(shift.startTime);
    final endTime = _formatShiftTime(shift.endTime);
    final duration = shift.durationHours?.toStringAsFixed(1) ?? '0.0';
    final statusCode = shift.status?.value?.toString() ?? 'pending';
    final clientName = shift.clientName as String? ?? 'Unknown Client';
    final employeeName = shift.employeeName as String? ?? 'Shift';
    final breakMin = shift.breakDuration ?? 0;

    final Color borderColor = () {
      switch (statusCode.toLowerCase()) {
        case 'active':
        case 'in_progress':
          return BauhausDesign.primary;
        case 'completed':
          return BauhausDesign.success;
        case 'cancelled':
          return BauhausDesign.neutral;
        default:
          return BauhausDesign.warning;
      }
    }();

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
          top: const BorderSide(color: BauhausDesign.neutral, width: 2),
          right: const BorderSide(color: BauhausDesign.neutral, width: 2),
          bottom: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$startTime — $endTime',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: BauhausDesign.textDark,
            ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            '$employeeName · ${duration}h · ${breakMin}m break',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            'Client: $clientName',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
          ),
        ],
      ),
    );
  }

  String _formatShiftTime(dynamic time) {
    if (time is DateTime) return DateFormat('h:mm a').format(time);
    if (time is String) {
      final parsed = DateTime.tryParse(time);
      if (parsed != null) return DateFormat('h:mm a').format(parsed);
      return time;
    }
    return '--:--';
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestsView(email: widget.email),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: BauhausDesign.space4,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.accent,
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: BauhausDesign.borderThick,
                ),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: BauhausDesign.textDark,
                    size: 28,
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  Text(
                    'REQUESTS',
                    style: BauhausDesign.getTextTheme(context).labelLarge
                        ?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: BauhausDesign.textDark,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: BauhausDesign.space4),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TimesheetView(email: widget.email),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: BauhausDesign.space4,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary,
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: BauhausDesign.borderThick,
                ),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: BauhausDesign.textLight,
                    size: 28,
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  Text(
                    'TIMESHEET',
                    style: BauhausDesign.getTextTheme(context).labelLarge
                        ?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: BauhausDesign.textLight,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
