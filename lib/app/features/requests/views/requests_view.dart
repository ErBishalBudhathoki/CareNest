import 'package:carenest/app/features/pricing/widgets/bauhaus_dashboard_components.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/offline_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/viewmodels/requests_viewmodel.dart';
import 'package:carenest/app/features/requests/views/add_shift_request_view.dart';
import 'package:carenest/app/features/requests/views/add_time_off_request_view.dart';
import 'package:carenest/app/features/requests/views/shift_exchange_view.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';

class RequestsView extends ConsumerStatefulWidget {
  final String? email;

  const RequestsView({super.key, this.email});

  @override
  ConsumerState<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends ConsumerState<RequestsView> {
  DateTimeRange? _selectedDateRange;
  String _searchQuery = '';
  String _statusFilter = 'all';
  bool _newestFirst = true;
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
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
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
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              AppLocalizations.of(context)!.createRequest,
              style: BauhausDesign.getTextTheme(
                context,
              ).headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Row(
              children: [
                Expanded(
                  child: BauhausActionCard(
                    title: AppLocalizations.of(context)!.requestTypeShift,
                    subtitle: AppLocalizations.of(
                      context,
                    )!.shiftRequestSubtitle,
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
                    subtitle: AppLocalizations.of(
                      context,
                    )!.timeOffRequestSubtitle,
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          const BauhausOfflineBanner(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.read(requestsViewModelProvider.notifier).refresh(),
              color: BauhausDesign.primary,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  RequestsAppBar(
                    title: AppLocalizations.of(context)!.requestsTitle,
                    actionLabel: AppLocalizations.of(context)!.newRequest,
                    onActionPressed: () =>
                        _showRequestOptions(context, userEmail),
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
                                  hintText: AppLocalizations.of(
                                    context,
                                  )!.searchRequestsHint,
                                  onChanged: (val) =>
                                      setState(() => _searchQuery = val),
                                  onClear: () =>
                                      setState(() => _searchQuery = ''),
                                ),
                              ),
                              const SizedBox(width: BauhausDesign.space3),
                              _buildDateRangePicker(),
                            ],
                          ),
                          const SizedBox(height: BauhausDesign.space3),
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _buildStatusChip(
                                        'all',
                                        AppLocalizations.of(context)!.statusAll,
                                      ),
                                      const SizedBox(
                                        width: BauhausDesign.space2,
                                      ),
                                      _buildStatusChip(
                                        'pending',
                                        AppLocalizations.of(
                                          context,
                                        )!.statusPending,
                                      ),
                                      const SizedBox(
                                        width: BauhausDesign.space2,
                                      ),
                                      _buildStatusChip(
                                        'approved',
                                        AppLocalizations.of(
                                          context,
                                        )!.statusApproved,
                                      ),
                                      const SizedBox(
                                        width: BauhausDesign.space2,
                                      ),
                                      _buildStatusChip(
                                        'rejected',
                                        AppLocalizations.of(
                                          context,
                                        )!.statusRejected,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              BauhausIconButton(
                                onPressed: () => setState(
                                  () => _newestFirst = !_newestFirst,
                                ),
                                icon: _newestFirst
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                variant: BauhausActionVariant.neutral,
                                isSmall: true,
                                tooltip: _newestFirst
                                    ? AppLocalizations.of(context)!.sortNewest
                                    : AppLocalizations.of(context)!.sortOldest,
                              ),
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
            ),
          ),
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
            child: BauhausLoadingSkeleton(height: 120, width: double.infinity),
          ),
          SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: BauhausLoadingSkeleton(height: 120, width: double.infinity),
          ),
          SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: BauhausLoadingSkeleton(height: 120, width: double.infinity),
          ),
        ],
      ),
      error: (_, _) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: BauhausDesign.error.withValues(alpha: 0.08),
          border: Border.all(color: BauhausDesign.error, width: 1.5),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: BauhausDesign.error),
            const SizedBox(width: BauhausDesign.space2),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.errorLoadingRequests,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            BauhausActionButton(
              text: AppLocalizations.of(context)!.retryButton,
              icon: Icons.refresh,
              isSmall: true,
              variant: BauhausActionVariant.error,
              onPressed: () =>
                  ref.read(requestsViewModelProvider.notifier).refresh(),
            ),
          ],
        ),
      ),
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
    final picked = await showBauhausDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialStart: _selectedDateRange?.start,
      initialEnd: _selectedDateRange?.end,
    );
    if (picked != null) {
      setState(() => _selectedDateRange = picked);
    }
  }

  DateTime? _requestDate(RequestModel r) {
    final startStr =
        r.details['starts'] ?? r.details['date'] ?? r.details['startDate'];
    if (startStr == null) return null;
    return DateTime.tryParse(startStr)?.toLocal();
  }

  Widget _buildStatusChip(String value, String label) {
    final selected = _statusFilter == value;
    return GestureDetector(
      onTap: () => setState(() => _statusFilter = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space3,
          vertical: BauhausDesign.space2,
        ),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.inverseSurface
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1.5,
          ),
          boxShadow: selected ? const [BauhausDesign.shadowHardSm] : [],
        ),
        child: Text(
          label.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
            color: selected
                ? Theme.of(context).colorScheme.onInverseSurface
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
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
              .where(
                (r) =>
                    r.type.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    (r.note?.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        ) ??
                        false),
              )
              .toList();
        }

        // Date Range Filter
        if (_selectedDateRange != null) {
          filtered = filtered.where((r) {
            final startStr =
                r.details['starts'] ??
                r.details['date'] ??
                r.details['startDate'];
            if (startStr == null) return false;
            final start = DateTime.tryParse(startStr)?.toLocal();
            if (start == null) return false;
            return start.isAfter(_selectedDateRange!.start) &&
                start.isBefore(
                  _selectedDateRange!.end.add(const Duration(days: 1)),
                );
          }).toList();
        }

        // Status Filter
        if (_statusFilter != 'all') {
          filtered = filtered
              .where((r) => r.status.name.toLowerCase() == _statusFilter)
              .toList();
        }

        // Date Sort (nulls last)
        filtered = [...filtered]
          ..sort((a, b) {
            final aDate = _requestDate(a);
            final bDate = _requestDate(b);
            if (aDate == null && bDate == null) return 0;
            if (aDate == null) return 1;
            if (bDate == null) return -1;
            return _newestFirst
                ? bDate.compareTo(aDate)
                : aDate.compareTo(bDate);
          });

        if (filtered.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: BauhausEmptyState(
                title: AppLocalizations.of(context)!.noMatchingRequests,
                message: AppLocalizations.of(
                  context,
                )!.noMatchingRequestsMessage,
                icon: Icons.search_off,
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final request = filtered[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space4,
                vertical: BauhausDesign.space2,
              ),
              child: _buildRequestCard(request),
            );
          }, childCount: filtered.length),
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
                child: BauhausLoadingSkeleton(
                  height: 100,
                  width: double.infinity,
                ),
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
        statusBgColor = BauhausDesign.success.withValues(alpha: 0.1);
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
      case 'declined':
        statusColor = BauhausDesign.error;
        statusBgColor = BauhausDesign.error.withValues(alpha: 0.1);
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = BauhausDesign.warning;
        statusBgColor = BauhausDesign.warning.withValues(alpha: 0.1);
        statusIcon = Icons.hourglass_empty;
    }

    final startStr =
        request.details['starts'] ??
        request.details['date'] ??
        request.details['startDate'] ??
        DateTime.now().toIso8601String();
    final endStr =
        request.details['ends'] ??
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
                      color: BauhausDesign.primary.withValues(alpha: 0.1),
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
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('MMM d, yyyy').format(startDate),
                        style: BauhausDesign.getTextTheme(context).bodySmall
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
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
                  border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: BauhausDesign.space1),
                    Text(
                      request.status.name.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context).labelSmall
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
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
              child: Text(
                request.note!,
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Appbar for the Requests dashboard.
///
/// Two things it deliberately does not do.
///
/// It is a single line. The original was `expandedHeight: 120` behind a
/// FlexibleSpaceBar, which reserved about 64px of empty black above the title
/// for a one-word heading. The title now sits in a normal toolbar of
/// `appBarCompactHeight`.
///
/// It does not colour the title with `colorScheme.surface`. That is the page
/// background token. It reads as near-white against the near-black bar in light
/// mode, but in dark mode surface and inverseSurface are both dark and the
/// title came out at 1.31:1 against its own background. `onInverseSurface` is
/// the paired content colour and measures 12.8:1 light, 15.2:1 dark.
///
/// Extracted as a named widget so the layout and contrast can be asserted
/// directly. A test that rebuilt this configuration by hand proved nothing.
class RequestsAppBar extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onActionPressed;

  const RequestsAppBar({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      pinned: true,
      toolbarHeight: BauhausDesign.appBarCompactHeight,
      backgroundColor: colorScheme.inverseSurface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      // inverseSurface is near-black in both schemes, so the status bar icons
      // stay light either way and the bar colour never needs to flip.
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleSpacing: BauhausDesign.space4,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onInverseSurface,
        ),
      ),
      actions: [
        // Kept as a labelled button rather than a bare + icon: the label is what
        // makes the action obvious. It is capped at 36px so it still fits a
        // single-line toolbar.
        Padding(
          padding: const EdgeInsets.only(right: BauhausDesign.space3),
          child: Center(
            child: SizedBox(
              height: 36,
              child: BauhausActionButton(
                onPressed: onActionPressed,
                text: actionLabel,
                icon: Icons.add,
                isSmall: true,
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
