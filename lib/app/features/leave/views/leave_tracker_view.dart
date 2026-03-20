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
      final viewModel = ref.read(leaveViewModelProvider(widget.userEmail));
      viewModel.loadForecast(_forecastTargetDate);
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
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        title: Text(
          l10n.leaveTracker,
          style: BauhausDesign.getTextTheme(context).headlineMedium,
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        centerTitle: true,
        elevation: 0,
        leading: BauhausIconButton(
          icon: Icons.arrow_back_ios_new,
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: viewModel.refresh,
        color: BauhausDesign.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(l10n.currentBalances),
              const SizedBox(height: BauhausDesign.space4),
              balancesAsync.when(
                data: (balances) => Column(
                  children: [
                    _buildBalanceCard(
                      "Annual Leave",
                      balances?.annualLeave ?? 0.0,
                      BauhausDesign.secondary,
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _buildBalanceCard(
                      "Personal / Sick Leave",
                      balances?.personalLeave ?? 0.0,
                      BauhausDesign.accent,
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _buildBalanceCard(
                      "Long Service Leave",
                      balances?.longServiceLeave ?? 0.0,
                      BauhausDesign.error,
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error loading balances: $e'),
              ),
              const SizedBox(height: BauhausDesign.space6),
              _buildSectionHeader("Forecast"),
              const SizedBox(height: BauhausDesign.space4),
              _buildForecastWidget(forecastAsync, viewModel),
              const SizedBox(height: BauhausDesign.space6),
              
              Row(
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      text: l10n.newRequestTitle, // "New Request"
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LeaveRequestForm(userEmail: widget.userEmail),
                          ),
                        );
                        viewModel.refresh();
                      },
                      isFullWidth: true,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    child: BauhausActionButton(
                        text: l10n.publicHoliday, // "Public Holiday"
                        icon: Icons.calendar_month,
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
                        variant: BauhausActionVariant.secondary,
                      ),
                  ),
                ],
              ),

              const SizedBox(height: BauhausDesign.space6),
              _buildSectionHeader(l10n.requestsLabel), // "Requests"
              const SizedBox(height: BauhausDesign.space4),
              requestsAsync.when(
                data: (requests) => _buildHistoryList(requests),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error loading requests: $e'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(left: BauhausDesign.space2),
      decoration: const BoxDecoration(
        border:
            Border(left: BorderSide(color: BauhausDesign.primary, width: 4)),
      ),
      child: Text(
        title,
        style: BauhausDesign.getTextTheme(context).headlineSmall,
      ),
    );
  }

  Widget _buildBalanceCard(String title, double hours, Color accentColor) {
    return BauhausCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                ),
                Text(
                  "Available Hours",
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              border: Border.all(color: accentColor.withOpacity(0.5), width: 1),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Text(
              "${hours.toStringAsFixed(2)} hrs",
              style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastWidget(AsyncValue<Map<String, dynamic>?> forecastAsync, LeaveViewModel viewModel) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Balance by ${DateFormat('dd MMM yyyy').format(_forecastTargetDate)}",
                style:
                    BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
              ),
              BauhausActionButton(
                text: "Change Date",
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
                    viewModel.loadForecast(_forecastTargetDate);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          forecastAsync.when(
            data: (data) {
              if (data == null) return const Text("Select a date to forecast");
              final forecast = (data['forecast'] as num?)?.toDouble() ?? 0.0;
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: forecast.toStringAsFixed(2),
                      style: BauhausDesign.getTextTheme(context).headlineMedium,
                    ),
                    TextSpan(
                      text: " hrs (Annual)",
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text("Error: $e"),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            "Based on your start date and standard accrual rates.",
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: BauhausDesign.textMuted,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<LeaveRequest> requests) {
    if (requests.isEmpty) {
      return BauhausEmptyState(
        title: "No History",
        message: "No leave requests found.",
        icon: Icons.history,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];
        BauhausChipVariant variant = BauhausChipVariant.neutral;
        if (req.status == 'Approved') variant = BauhausChipVariant.success;
        if (req.status == 'Rejected') variant = BauhausChipVariant.error;
        if (req.status == 'Pending') variant = BauhausChipVariant.warning;

        return Padding(
          padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
          child: BauhausCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      req.leaveType,
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    BauhausChip(
                      label: req.status.toUpperCase(),
                      variant: variant,
                      isSmall: true,
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  "${DateFormat('dd MMM').format(req.startDate)} - ${DateFormat('dd MMM yyyy').format(req.endDate)}",
                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                ),
                if (req.reason.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: BauhausDesign.space2),
                    child: Text(
                      "Reason: ${req.reason}",
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
