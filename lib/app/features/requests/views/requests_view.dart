import 'package:carenest/app/features/pricing/widgets/bauhaus_dashboard_components.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/viewmodels/requests_viewmodel.dart';
import 'package:carenest/app/features/requests/views/add_shift_request_view.dart';
import 'package:carenest/app/features/requests/views/add_time_off_request_view.dart';
import 'package:carenest/app/features/requests/views/shift_exchange_view.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class RequestsView extends ConsumerStatefulWidget {
  final String? email;

  const RequestsView({super.key, this.email});

  @override
  ConsumerState<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends ConsumerState<RequestsView> {
  DateTimeRange? _selectedDateRange;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showRequestOptions(BuildContext context, String email) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(BauhausDesign.radiusLg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: BauhausDesign.neutral.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              AppLocalizations.of(context)!.createRequest,
              style:
                  BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Row(
              children: [
                Expanded(
                  child: BauhausActionCard(
                    title: AppLocalizations.of(context)!.requestTypeShift,
                    subtitle:
                        AppLocalizations.of(context)!.shiftRequestSubtitle,
                    icon: Icons.calendar_month,
                    color: BauhausDesign.primary,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: AddShiftRequestView(email: email),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: BauhausActionCard(
                    title: AppLocalizations.of(context)!.requestTypeTimeOff,
                    subtitle:
                        AppLocalizations.of(context)!.timeOffRequestSubtitle,
                    icon: Icons.beach_access,
                    color: BauhausDesign.secondary,
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: AddTimeOffRequestView(email: email),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            BauhausActionCard(
              title: AppLocalizations.of(context)!.requestTypeShiftExchange,
              subtitle: AppLocalizations.of(context)!.shiftExchangeSubtitle,
              icon: Icons.swap_horiz,
              color: BauhausDesign.accent,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShiftExchangeView(),
                  ),
                );
              },
              isEnabled: true,
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final requestsState = ref.watch(requestsViewModelProvider);
    final prefs = SharedPreferencesUtils();
    final userEmail = prefs.getUserEmail() ?? '';

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: BauhausDesign.surfaceWhite,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: BauhausDesign.space4,
                bottom: 16,
              ),
              title: Text(
                AppLocalizations.of(context)!.requestsTitle,
                style:
                    BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                        ),
              ),
              background: Container(
                color: BauhausDesign.surfaceWhite,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: BauhausActionButton(
                  onPressed: () => _showRequestOptions(context, userEmail),
                  text: AppLocalizations.of(context)!.newRequest,
                  icon: Icons.add,
                  isSmall: true,
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: BauhausDesign.neutral.withOpacity(0.2),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummarySection(requestsState),
                  const SizedBox(height: BauhausDesign.space4),
                  Row(
                    children: [
                      Expanded(
                        child: BauhausSearchBar(
                          controller: _searchController,
                          hintText:
                              AppLocalizations.of(context)!.searchRequestsHint,
                          onChanged: (val) =>
                              setState(() => _searchQuery = val),
                          onClear: () => setState(() => _searchQuery = ''),
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      _buildDateRangePicker(),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                ],
              ),
            ),
          ),
          _buildRequestList(requestsState),
          const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }

  Widget _buildSummarySection(AsyncValue<List<RequestModel>> requestsState) {
    return requestsState.when(
      data: (requests) {
        final pending = requests
            .where((r) => r.status.name.toLowerCase() == 'pending')
            .length;
        final approved = requests
            .where((r) => r.status.name.toLowerCase() == 'approved')
            .length;
        final rejected = requests
            .where((r) => r.status.name.toLowerCase() == 'rejected')
            .length;

        return Row(
          children: [
            Expanded(
              child: BauhausMetricCard(
                title: AppLocalizations.of(context)!.statusPending,
                value: pending.toString(),
                icon: Icons.hourglass_empty,
                iconColor: BauhausDesign.warning,
                // No trend data available yet, skipping
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: BauhausMetricCard(
                title: AppLocalizations.of(context)!.statusApproved,
                value: approved.toString(),
                icon: Icons.check_circle_outline,
                iconColor: BauhausDesign.success,
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: BauhausMetricCard(
                title: AppLocalizations.of(context)!.statusRejected,
                value: rejected.toString(),
                icon: Icons.cancel_outlined,
                iconColor: BauhausDesign.error,
              ),
            ),
          ],
        );
      },
      loading: () => const Row(
        children: [
          Expanded(
              child:
                  BauhausLoadingSkeleton(height: 120, width: double.infinity)),
          SizedBox(width: BauhausDesign.space3),
          Expanded(
              child:
                  BauhausLoadingSkeleton(height: 120, width: double.infinity)),
          SizedBox(width: BauhausDesign.space3),
          Expanded(
              child:
                  BauhausLoadingSkeleton(height: 120, width: double.infinity)),
        ],
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildDateRangePicker() {
    return BauhausIconButton(
      onPressed: _selectDateRange,
      icon: Icons.calendar_today,
      variant: _selectedDateRange != null
          ? BauhausActionVariant.primary
          : BauhausActionVariant.neutral,
      tooltip: AppLocalizations.of(context)!.selectDateRange,
    );
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: BauhausDesign.primary,
              onPrimary: BauhausDesign.surfaceWhite,
              onSurface: BauhausDesign.textDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDateRange = picked);
    }
  }

  Widget _buildRequestList(AsyncValue<List<RequestModel>> requestsState) {
    return requestsState.when(
      data: (requests) {
        if (requests.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: BauhausEmptyState(
                title: AppLocalizations.of(context)!.noRequestsFound,
                message: AppLocalizations.of(context)!.noRequestsMessage,
                icon: Icons.assignment_outlined,
                actionLabel: AppLocalizations.of(context)!.createRequest,
                onAction: () {
                  final prefs = SharedPreferencesUtils();
                  _showRequestOptions(context, prefs.getUserEmail() ?? '');
                },
              ),
            ),
          );
        }

        var filtered = requests;
        // Search Filter
        if (_searchQuery.isNotEmpty) {
          filtered = filtered
              .where((r) =>
                  r.type.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  (r.note?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
                      false))
              .toList();
        }

        // Date Range Filter
        if (_selectedDateRange != null) {
          filtered = filtered.where((r) {
            final startStr = r.details['starts'] ??
                r.details['date'] ??
                r.details['startDate'];
            if (startStr == null) return false;
            final start = DateTime.parse(startStr).toLocal();
            return start.isAfter(_selectedDateRange!.start) &&
                start.isBefore(
                    _selectedDateRange!.end.add(const Duration(days: 1)));
          }).toList();
        }

        if (filtered.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: BauhausEmptyState(
                title: AppLocalizations.of(context)!.noMatchingRequests,
                message:
                    AppLocalizations.of(context)!.noMatchingRequestsMessage,
                icon: Icons.search_off,
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final request = filtered[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space4,
                  vertical: BauhausDesign.space2,
                ),
                child: _buildRequestCard(request),
              );
            },
            childCount: filtered.length,
          ),
        );
      },
      loading: () => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            children: List.generate(
              3,
              (index) => const Padding(
                padding: EdgeInsets.only(bottom: BauhausDesign.space3),
                child:
                    BauhausLoadingSkeleton(height: 100, width: double.infinity),
              ),
            ),
          ),
        ),
      ),
      error: (e, s) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Text(AppLocalizations.of(context)!.requestError(e.toString())),
        ),
      ),
    );
  }

  Widget _buildRequestCard(RequestModel request) {
    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;

    switch (request.status.name.toLowerCase()) {
      case 'approved':
        statusColor = BauhausDesign.success;
        statusBgColor = BauhausDesign.success.withOpacity(0.1);
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
      case 'declined':
        statusColor = BauhausDesign.error;
        statusBgColor = BauhausDesign.error.withOpacity(0.1);
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = BauhausDesign.warning;
        statusBgColor = BauhausDesign.warning.withOpacity(0.1);
        statusIcon = Icons.hourglass_empty;
    }

    final startStr = request.details['starts'] ??
        request.details['date'] ??
        request.details['startDate'] ??
        DateTime.now().toIso8601String();
    final endStr = request.details['ends'] ??
        request.details['endDate'] ??
        request
            .details['endTime']; // endTime might just be time string, careful.

    // Safe parsing
    DateTime startDate;
    try {
      startDate = DateTime.parse(startStr).toLocal();
    } catch (_) {
      startDate = DateTime.now();
    }

    DateTime endDate;
    if (endStr != null) {
      try {
        endDate = DateTime.parse(endStr).toLocal();
      } catch (_) {
        // fallback if string is just time "17:00" or similar, or null
        endDate = startDate.add(const Duration(hours: 1));
      }
    } else {
      endDate = startDate.add(const Duration(hours: 1));
    }

    // Determine icon based on request type
    IconData typeIcon = Icons.assignment;
    if (request.type.toLowerCase().contains('shift')) {
      typeIcon = Icons.calendar_month;
    } else if (request.type.toLowerCase().contains('time off')) {
      typeIcon = Icons.beach_access;
    }

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space2),
                    decoration: BoxDecoration(
                      color: BauhausDesign.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      typeIcon,
                      color: BauhausDesign.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.type,
                        style: BauhausDesign.getTextTheme(context)
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        DateFormat('MMM d, yyyy').format(startDate),
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
                  border: Border.all(color: statusColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: BauhausDesign.space1),
                    Text(
                      request.status.name.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Text(
                '${DateFormat('h:mm a').format(startDate)} - ${DateFormat('h:mm a').format(endDate)}',
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
              const Spacer(),
              Icon(
                Icons.timer,
                size: 16,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Text(
                '${endDate.difference(startDate).inHours}h ${endDate.difference(startDate).inMinutes.remainder(60)}m',
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ],
          ),
          if (request.note != null && request.note!.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space3),
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space2),
              width: double.infinity,
              decoration: BoxDecoration(
                color: BauhausDesign.neutral.withOpacity(0.05),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
              child: Text(
                request.note!,
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: BauhausDesign.textMuted,
                    ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
