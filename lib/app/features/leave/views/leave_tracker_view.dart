import 'package:carenest/app/features/leave/models/leave_request_model.dart';
import 'package:carenest/app/features/leave/providers/leave_providers.dart';
import 'package:carenest/app/features/leave/viewmodels/leave_viewmodel.dart';
import 'package:carenest/app/features/leave/views/leave_request_form.dart';
import 'package:carenest/app/features/holiday/views/holiday_list_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class LeaveTrackerView extends ConsumerStatefulWidget {
  final String userEmail;

  const LeaveTrackerView({super.key, required this.userEmail});

  @override
  ConsumerState<LeaveTrackerView> createState() => _LeaveTrackerViewState();
}

class _LeaveTrackerViewState extends ConsumerState<LeaveTrackerView> {
  DateTime _forecastTargetDate = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = ref.read(
        leaveViewModelProvider(widget.userEmail).notifier,
      );
      ref
          .read(leaveViewModelProvider(widget.userEmail).notifier)
          .loadForecast(_forecastTargetDate);
      viewModel.fetchHolidays();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(leaveViewModelProvider(widget.userEmail));
    final balancesAsync = ref.watch(leaveBalancesProvider(widget.userEmail));
    final requestsAsync = ref.watch(leaveRequestsProvider(widget.userEmail));
    final forecastAsync = ref.watch(leaveForecastProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          l10n.leaveTracker,
          style: BauhausDesign.getTextTheme(context).headlineMedium,
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space2),
          child: BauhausIconButton(
            icon: Icons.arrow_back_ios_new,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ref
            .read(leaveViewModelProvider(widget.userEmail).notifier)
            .refresh,
        color: BauhausDesign.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(BauhausDesign.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── BALANCES ──
              _buildSectionHeader(l10n.currentBalances),
              const SizedBox(height: BauhausDesign.space4),
              balancesAsync.when(
                data: (balances) => Column(
                  children: [
                    _buildBalanceCard(
                      'Annual Leave',
                      balances?.annualLeave ?? 0.0,
                      Icons.beach_access_outlined,
                      BauhausDesign.secondary,
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _buildBalanceCard(
                      'Personal / Sick Leave',
                      balances?.personalLeave ?? 0.0,
                      Icons.healing_outlined,
                      BauhausDesign.accent,
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _buildBalanceCard(
                      'Long Service Leave',
                      balances?.longServiceLeave ?? 0.0,
                      Icons.workspace_premium_outlined,
                      BauhausDesign.error,
                    ),
                  ],
                ),
                loading: () => _buildSkeleton(),
                error: (e, _) => _buildErrorCard('Failed to load balances'),
              ),

              const SizedBox(height: BauhausDesign.space8),

              // ── FORECAST ──
              _buildSectionHeader('Forecast'),
              const SizedBox(height: BauhausDesign.space4),
              _buildForecastCard(forecastAsync, viewModel),

              const SizedBox(height: BauhausDesign.space8),

              // ── ACTIONS ──
              _buildSectionHeader('Actions'),
              const SizedBox(height: BauhausDesign.space4),
              Row(
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      text: l10n.newRequestTitle,
                      icon: Icons.add_circle_outline,
                      variant: BauhausActionVariant.primary,
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LeaveRequestForm(userEmail: widget.userEmail),
                          ),
                        );
                        ref
                            .read(
                              leaveViewModelProvider(widget.userEmail).notifier,
                            )
                            .refresh();
                      },
                      isFullWidth: true,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    child: BauhausActionButton(
                      text: l10n.publicHoliday,
                      icon: Icons.calendar_month_outlined,
                      variant: BauhausActionVariant.secondary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HolidayListView(
                              holidays: viewModel.holidays,
                              readonly: true,
                            ),
                          ),
                        );
                      },
                      isFullWidth: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: BauhausDesign.space8),

              // ── HISTORY ──
              _buildSectionHeader(l10n.requestsLabel),
              const SizedBox(height: BauhausDesign.space4),
              requestsAsync.when(
                data: (requests) => _buildHistoryList(requests),
                loading: () => _buildSkeleton(),
                error: (e, _) => _buildErrorCard('Failed to load requests'),
              ),

              const SizedBox(height: BauhausDesign.space4),
            ],
          ),
        ),
      ),
    );
  }

  // ── SECTION HEADER ──

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(left: BauhausDesign.space2),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: BauhausDesign.primary, width: 4),
        ),
      ),
      child: Text(
        title.toUpperCase(),
        style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // ── BALANCE CARD ──

  Widget _buildBalanceCard(
    String title,
    double hours,
    IconData icon,
    Color accentColor,
  ) {
    final days = (hours / 7.6).ceil();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.textDark, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color accent bar
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: accentColor,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.textDark, width: 2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    border: Border.all(
                      color: accentColor.withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(icon, color: accentColor, size: 24),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: BauhausDesign.textDark,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        '$days day${days == 1 ? '' : 's'} available',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: BauhausDesign.textMuted,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hours.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: accentColor,
                        fontFamily: 'Oswald',
                      ),
                    ),
                    const Text(
                      'HOURS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.textMuted,
                        letterSpacing: 1.2,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── FORECAST CARD ──

  Widget _buildForecastCard(
    AsyncValue<Map<String, dynamic>?> forecastAsync,
    LeaveViewModelState viewModel,
  ) {
    final dateStr = DateFormat('dd MMM yyyy').format(_forecastTargetDate);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.textDark, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceOffWhite,
                  border: Border.all(color: BauhausDesign.textDark, width: 2),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: BauhausDesign.textDark,
                  size: 20,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PROJECTED BALANCE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: BauhausDesign.textMuted,
                        letterSpacing: 1,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dateStr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.textDark,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              BauhausActionButton(
                text: 'Change',
                isSmall: true,
                variant: BauhausActionVariant.neutral,
                isOutlined: true,
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _forecastTargetDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                  );
                  if (picked != null) {
                    setState(() => _forecastTargetDate = picked);
                    ref
                        .read(leaveViewModelProvider(widget.userEmail).notifier)
                        .loadForecast(_forecastTargetDate);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
              vertical: BauhausDesign.space3,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceOffWhite,
              border: Border.all(color: BauhausDesign.textDark, width: 2),
            ),
            child: forecastAsync.when(
              data: (data) {
                if (data == null) {
                  return const Text(
                    'Select a date to forecast',
                    style: TextStyle(
                      color: BauhausDesign.textMuted,
                      fontFamily: 'Inter',
                    ),
                  );
                }
                final forecast = (data['forecast'] as num?)?.toDouble() ?? 0.0;
                final days = (forecast / 7.6).ceil();
                return Row(
                  children: [
                    Text(
                      forecast.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: BauhausDesign.textDark,
                        fontFamily: 'Oswald',
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'HOURS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: BauhausDesign.textMuted,
                            letterSpacing: 1,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          '≈ $days day${days == 1 ? '' : 's'}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textDark,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(
                height: 40,
                child: Center(child: BauhausLoadingState(showMessage: false)),
              ),
              error: (e, _) => Text(
                'Error loading forecast',
                style: const TextStyle(color: BauhausDesign.error),
              ),
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          const Text(
            'Based on your start date and standard accrual rates.',
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: BauhausDesign.textMuted,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  // ── HISTORY LIST ──

  Widget _buildHistoryList(List<LeaveRequest> requests) {
    if (requests.isEmpty) {
      return BauhausEmptyState(
        title: 'No Requests',
        message: 'No leave requests found.',
        icon: Icons.history,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];
        return _buildRequestCard(req);
      },
    );
  }

  Widget _buildRequestCard(LeaveRequest req) {
    final isApproved = req.status == 'Approved';
    final isRejected = req.status == 'Rejected';
    final isPending = req.status == 'Pending';

    final Color statusColor = isApproved
        ? BauhausDesign.success
        : isRejected
        ? BauhausDesign.error
        : isPending
        ? BauhausDesign.warning
        : BauhausDesign.neutral;

    final String statusLabel = req.status.toUpperCase();
    final Color statusBg = statusColor.withOpacity(0.10);

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.textDark, width: 2),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space2,
              ),
              decoration: BoxDecoration(
                color: statusBg,
                border: Border(
                  bottom: BorderSide(color: BauhausDesign.textDark, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    req.leaveType,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: BauhausDesign.textDark,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space2,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      border: Border.all(
                        color: BauhausDesign.textDark,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      statusLabel,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: BauhausDesign.surfaceWhite,
                        letterSpacing: 0.8,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        size: 16,
                        color: BauhausDesign.textMuted,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Text(
                        "${DateFormat('dd MMM').format(req.startDate)} — ${DateFormat('dd MMM yyyy').format(req.endDate)}",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: BauhausDesign.textDark,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  if (req.reason.isNotEmpty) ...[
                    const SizedBox(height: BauhausDesign.space3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          size: 14,
                          color: BauhausDesign.textMuted,
                        ),
                        const SizedBox(width: BauhausDesign.space2),
                        Expanded(
                          child: Text(
                            req.reason,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: BauhausDesign.textMuted,
                              height: 1.4,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── HELPERS ──

  Widget _buildSkeleton() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral.withOpacity(0.3)),
      ),
      child: const Center(child: BauhausLoadingState(showMessage: false)),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.error, width: 2),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: BauhausDesign.error,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
