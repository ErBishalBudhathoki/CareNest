import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, listEquals;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;

import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import '../viewmodels/employee_tracking_viewmodel.dart';
import '../widgets/employee_status_card.dart';
import '../widgets/employee_stats_overview.dart';
import '../models/employee_tracking_model.dart';

class EmployeeTrackingView extends ConsumerStatefulWidget {
  const EmployeeTrackingView({super.key});

  @override
  ConsumerState<EmployeeTrackingView> createState() =>
      _EmployeeTrackingViewState();
}

class _EmployeeTrackingViewState extends ConsumerState<EmployeeTrackingView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  Timer? _refreshTimer;
  static const Duration _refreshInterval = Duration(seconds: 30);

  @override
  void initState() {
    super.initState();

    // Debug statements for EmployeeTrackingView initialization
    debugPrint('🔍 DEBUG: EmployeeTrackingView initState() called');
    debugPrint(
        '🔍 DEBUG: Initializing TabController and loading employee data...');

    _tabController = TabController(length: 3, vsync: this);

    // Add lifecycle observer
    WidgetsBinding.instance.addObserver(this);

    // Load employee tracking data when view is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint(
          '🔍 DEBUG: Post-frame callback - Loading employee tracking data');
      ref
          .read(employeeTrackingViewModelProvider.notifier)
          .loadEmployeeTrackingData();

      // Start periodic refresh timer
      _startPeriodicRefresh();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('🔍 DEBUG: App lifecycle state changed to: $state');

    switch (state) {
      case AppLifecycleState.resumed:
        // App came to foreground, restart timer and refresh data
        debugPrint(
            '🔍 DEBUG: App resumed - restarting timer and refreshing data');
        _startPeriodicRefresh();
        _refreshData();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        // App went to background, stop timer to save battery
        debugPrint('🔍 DEBUG: App paused/inactive - stopping timer');
        _stopPeriodicRefresh();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void _startPeriodicRefresh() {
    // Don't start a new timer if one is already running
    if (_refreshTimer?.isActive == true) {
      debugPrint('🔍 DEBUG: Timer already active, skipping start');
      return;
    }

    debugPrint(
        '🔍 DEBUG: Starting periodic refresh timer (${_refreshInterval.inSeconds}s interval)');
    _refreshTimer = Timer.periodic(_refreshInterval, (timer) {
      debugPrint('🔍 DEBUG: Periodic refresh triggered');
      _refreshData();
    });
  }

  void _stopPeriodicRefresh() {
    debugPrint('🔍 DEBUG: Stopping periodic refresh timer');
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  Future<void> _refreshData() async {
    debugPrint(
        '🔍 DEBUG: _refreshData() called - refreshing employee tracking data');
    try {
      await ref
          .read(employeeTrackingViewModelProvider.notifier)
          .refreshEmployeeTrackingData();
      debugPrint('🔍 DEBUG: Employee tracking data refreshed successfully');
    } catch (e) {
      debugPrint('🔍 DEBUG: Error refreshing employee tracking data: $e');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopPeriodicRefresh();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackingState = ref.watch(employeeTrackingViewModelProvider);
    final stats = ref.watch(employeeStatsProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(),
      body: trackingState.when(
        data: (state) => _buildContent(state, stats),
        loading: () => _buildLoadingState(),
        error: (error, stackTrace) => _buildErrorState(error.toString()),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: BauhausDesign.primary,
        ),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: BauhausDesign.surfaceWhite,
      title: Text(
        'Employee Tracking',
        style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
              color: BauhausDesign.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
      ),
      actions: [
        BauhausActionButton(
          icon: Icons.refresh,
          onPressed: () => _refreshData(),
          backgroundColor: BauhausDesign.surfaceWhite.withOpacity(0.2),
          textColor: BauhausDesign.surfaceWhite,
          variant: BauhausActionVariant.ghost,
        ),
        const SizedBox(width: BauhausDesign.space2),
        BauhausActionButton(
          icon: Icons.filter_list,
          onPressed: () => _showFilterBottomSheet(),
          backgroundColor: BauhausDesign.surfaceWhite.withOpacity(0.2),
          textColor: BauhausDesign.surfaceWhite,
          variant: BauhausActionVariant.ghost,
        ),
        const SizedBox(width: BauhausDesign.space4),
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: BauhausDesign.surfaceWhite,
        indicatorWeight: 3,
        labelColor: BauhausDesign.surfaceWhite,
        unselectedLabelColor: BauhausDesign.surfaceWhite.withOpacity(0.7),
        labelStyle: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        tabs: const [
          Tab(text: 'Overview', icon: Icon(Icons.dashboard, size: 20)),
          Tab(text: 'Employees', icon: Icon(Icons.people, size: 20)),
          Tab(text: 'Shifts', icon: Icon(Icons.schedule, size: 20)),
        ],
      ),
    );
  }

  Widget _buildContent(EmployeeTrackingState state, Map<String, int> stats) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: BauhausDesign.primary,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(state, stats),
          _buildEmployeesTab(state, stats),
          _buildShiftsTab(state),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(
      EmployeeTrackingState state, Map<String, int> stats) {
    // Debug print to inspect state before passing to _buildRecentActivitySection
    debugPrint(
        '🔍 DEBUG: State before _buildRecentActivitySection: ${state.toString()}');
    debugPrint('🔍 DEBUG: State data: ${state.data.toString()}');
    debugPrint('🔍 DEBUG: State employees: ${state.data.employees.toString()}');

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewHeader(state.isRefreshing),
            const SizedBox(height: BauhausDesign.space5),
            _buildWorkforceStatusSection(stats),
            const SizedBox(height: BauhausDesign.space6),
            _buildLiveZoneSection(state),
            const SizedBox(height: BauhausDesign.space6),
            _buildQuickActionsSection(),
            const SizedBox(height: BauhausDesign.space6),
            _buildRecentActivitySection(state),
            const SizedBox(height: BauhausDesign.space6),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewHeader(bool isRefreshing) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SYSTEM v2.024',
                  style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                        color: BauhausDesign.textMuted,
                        letterSpacing: 0.8,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  'EMPLOYEE\nTRACKING',
                  style: BauhausDesign.getTextTheme(context)
                      .headlineLarge
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space2,
                    vertical: BauhausDesign.space1,
                  ),
                  decoration: BoxDecoration(
                    color: isRefreshing
                        ? BauhausDesign.warning
                        : BauhausDesign.accent,
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                  ),
                  child: Text(
                    isRefreshing ? 'SYNCING' : 'LIVE FEED',
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: BauhausDesign.accent,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: const Icon(Icons.track_changes,
                color: BauhausDesign.neutral, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String index, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$index/ $title',
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: BauhausDesign.textDark,
                letterSpacing: 0.6,
              ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Container(height: 2, color: BauhausDesign.neutral),
      ],
    );
  }

  Widget _buildWorkforceStatusSection(Map<String, int> stats) {
    final total = stats['total'] ?? 0;
    final active = stats['active'] ?? 0;
    final onBreak = stats['onBreak'] ?? 0;
    final offline = stats['offline'] ?? 0;
    final activePct =
        total > 0 ? ((active / total) * 100).round() : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('01', 'WORKFORCE STATUS'),
        const SizedBox(height: BauhausDesign.space4),
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVE NOW',
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                            letterSpacing: 0.8,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      active.toString().padLeft(2, '0'),
                      style: BauhausDesign.getTextTheme(context)
                          .displayMedium
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: BauhausDesign.success,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: Text(
                  '+$activePct%',
                  style: BauhausDesign.getTextTheme(context)
                      .labelSmall
                      ?.copyWith(
                        color: BauhausDesign.surfaceWhite,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: BauhausDesign.space4),
        Row(
          children: [
            Expanded(
              child: _smallStatusCard(
                title: 'ON BREAK',
                value: onBreak,
                subtitle: 'Δ INCREASE',
                background: BauhausDesign.surfaceWhite,
                accent: BauhausDesign.primary,
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: _smallStatusCard(
                title: 'OFFLINE',
                value: offline,
                subtitle: 'NO CHANGE',
                background: BauhausDesign.neutral,
                accent: BauhausDesign.surfaceWhite,
                invertText: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _smallStatusCard({
    required String title,
    required int value,
    required String subtitle,
    required Color background,
    required Color accent,
    bool invertText = false,
  }) {
    final textColor =
        invertText ? BauhausDesign.surfaceWhite : BauhausDesign.textDark;
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: textColor,
                  letterSpacing: 0.8,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            value.toString().padLeft(2, '0'),
            style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space2,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: accent,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
            ),
            child: Text(
              subtitle,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: invertText
                        ? BauhausDesign.neutral
                        : BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveZoneSection(EmployeeTrackingState state) {
    final liveEmployees = state.data.employees
        .where(
          (employee) =>
              employee.liveLatitude != null &&
              employee.liveLongitude != null,
        )
        .toList()
      ..sort((a, b) {
        final aSeen =
            a.liveUpdatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bSeen =
            b.liveUpdatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bSeen.compareTo(aSeen);
      });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('02', 'LIVE ZONE'),
        const SizedBox(height: BauhausDesign.space4),
        Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                  vertical: BauhausDesign.space2,
                ),
                decoration: BoxDecoration(
                  color: BauhausDesign.primaryBlue,
                  border: Border(
                    bottom:
                        BorderSide(color: BauhausDesign.neutral, width: 2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'DISTRICT ALPHA // GRID 7',
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              letterSpacing: 0.6,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceWhite,
                        border:
                            Border.all(color: BauhausDesign.neutral, width: 2),
                      ),
                      child: Text(
                        '${liveEmployees.length} LIVE',
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              if (liveEmployees.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceOffWhite,
                          border: Border.all(
                              color: BauhausDesign.neutral, width: 2),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Center(
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: BauhausDesign.surfaceWhite,
                              border: Border.all(
                                  color: BauhausDesign.neutral, width: 2),
                            ),
                            child: const Icon(Icons.gps_fixed,
                                color: BauhausDesign.primary, size: 22),
                          ),
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      Text(
                        'NO LIVE SIGNALS',
                        style: BauhausDesign.getTextTheme(context)
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Employee live zones will appear once activity begins.',
                        textAlign: TextAlign.center,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 220,
                        child: _LiveZoneMap(employees: liveEmployees),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Column(
                        children: liveEmployees
                            .map(_buildLiveZoneEmployeeCard)
                            .toList(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLiveZoneEmployeeCard(EmployeeStatus employee) {
    final statusColor = _statusColor(employee.status);
    final statusLabel = _statusLabel(employee.status);
    final location = (employee.liveClientName == null ||
            employee.liveClientName!.isEmpty)
        ? (employee.currentLocation == null ||
                employee.currentLocation!.isEmpty)
            ? 'Location pending'
            : employee.currentLocation!
        : employee.liveClientName!;
    final lastSeen = _formatLastSeen(employee.liveUpdatedAt ?? employee.lastSeen);
    final coords = _formatCoordinates(employee);
    final distance = employee.liveDistanceMeters != null
        ? '${employee.liveDistanceMeters!.round()}m'
        : null;

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardXs],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusColor,
                  border: Border.all(color: BauhausDesign.neutral, width: 1),
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  employee.name,
                  style: BauhausDesign.getTextTheme(context)
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                statusLabel,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                      letterSpacing: 0.6,
                    ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            location,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          if (coords != null)
            Text(
              coords,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textMuted,
                    fontSize: 12,
                  ),
            ),
          if (distance != null) ...[
            const SizedBox(height: BauhausDesign.space1),
            Text(
              'Distance to geofence: $distance',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textMuted,
                    fontSize: 12,
                  ),
            ),
          ],
          Text(
            'Last seen: $lastSeen',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesTab(
      EmployeeTrackingState state, Map<String, int> stats) {
    return Column(
      children: [
        const SizedBox(height: BauhausDesign.space4),
        EmployeeFilterChips(
          selectedFilter: state.selectedFilter,
          onFilterChanged: (filter) {
            ref
                .read(employeeTrackingViewModelProvider.notifier)
                .setEmployeeFilter(filter);
          },
          statusCounts: ref.watch(employeeStatusCountsProvider),
        ),
        const SizedBox(height: BauhausDesign.space4),
        Expanded(
          child: _buildEmployeesList(state),
        ),
      ],
    );
  }

  Widget _buildShiftsTab(EmployeeTrackingState state) {
    if (state.data.shifts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                  ),
                  child: const Icon(Icons.schedule,
                      color: BauhausDesign.textMuted, size: 30),
                ),
                const SizedBox(height: BauhausDesign.space3),
                Text(
                  'NO SHIFTS SCHEDULED',
                  style: BauhausDesign.getTextTheme(context)
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  'Assign employees to shifts to see live coverage and activity.',
                  style: BauhausDesign.getTextTheme(context)
                      .bodyMedium
                      ?.copyWith(color: BauhausDesign.textMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: BauhausDesign.space3),
                Wrap(
                  spacing: BauhausDesign.space3,
                  runSpacing: BauhausDesign.space3,
                  alignment: WrapAlignment.center,
                  children: [
                    BauhausActionButton(
                      text: 'CREATE SHIFT',
                      onPressed: _navigateToAssignTab,
                      backgroundColor: BauhausDesign.primary,
                      textColor: BauhausDesign.surfaceWhite,
                    ),
                    BauhausActionButton(
                      text: 'REFRESH',
                      onPressed: _refreshData,
                      backgroundColor: BauhausDesign.neutral,
                      textColor: BauhausDesign.surfaceWhite,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: BauhausDesign.space4),
          ...state.data.shifts.map((shift) => _buildShiftCard(shift)),
          const SizedBox(height: BauhausDesign.space8),
        ],
      ),
    );
  }

  Widget _buildEmployeesList(EmployeeTrackingState state) {
    final filteredEmployees = state.selectedFilter == null
        ? state.data.employees
        : state.data.employees
            .where((e) => e.status == state.selectedFilter)
            .toList();

    if (filteredEmployees.isEmpty) {
      return _buildEmptyState('No employees found');
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: filteredEmployees.length,
      itemBuilder: (context, index) {
        final employee = filteredEmployees[index];
        return EmployeeStatusCard(
          employee: employee,
          onTap: () => _showEmployeeDetails(employee),
        )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: 400.ms)
            .slideX(begin: 0.2, end: 0);
      },
    );
  }

  Widget _buildRecentActivitySection(EmployeeTrackingState state) {
    debugPrint('🔍 DEBUG: Inside _buildRecentActivitySection');
    debugPrint(
        '🔍 DEBUG: Number of employees in state: ${state.data.employees.length}');

    final recentEmployees = state.data.employees.where((e) {
      debugPrint('🔍 DEBUG: Employee ${e.name} lastSeen: ${e.lastSeen}');
      return e.lastSeen != null;
    }).toList()
      ..sort((a, b) => b.lastSeen!.compareTo(a.lastSeen!));

    debugPrint(
        '🔍 DEBUG: Number of employees with lastSeen: ${recentEmployees.length}');
    if (recentEmployees.isNotEmpty) {
      debugPrint(
          '🔍 DEBUG: First recent employee: ${recentEmployees.first.name}, lastSeen: ${recentEmployees.first.lastSeen}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('04', 'RECENT ACTIVITY'),
        const SizedBox(height: BauhausDesign.space4),
        if (recentEmployees.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Column(
              children: recentEmployees
                  .take(3)
                  .map((employee) => EmployeeStatusCard(
                        employee: employee,
                        onTap: () => _showEmployeeDetails(employee),
                        showDetails: false,
                      ))
                  .toList(),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: BauhausDesign.primary, width: 6),
                ),
              ),
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                children: [
                  const SizedBox(height: BauhausDesign.space1),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceOffWhite,
                      border:
                          Border.all(color: BauhausDesign.neutral, width: 2),
                    ),
                    child: const Icon(Icons.inbox,
                        color: BauhausDesign.textMuted, size: 30),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Text(
                    'QUEUE EMPTY',
                    style: BauhausDesign.getTextTheme(context)
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    'Synchronizing modules — check in will be logged once data pipelines are online.',
                    textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(color: BauhausDesign.textMuted),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  BauhausActionButton(
                    text: 'FORCE SYNC',
                    onPressed: _refreshData,
                    backgroundColor: BauhausDesign.neutral,
                    textColor: BauhausDesign.surfaceWhite,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('03', 'ACTIONS'),
        const SizedBox(height: BauhausDesign.space4),
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 360;
            final tileWidth = isNarrow
                ? constraints.maxWidth
                : (constraints.maxWidth - BauhausDesign.space4) / 2;

            return Wrap(
              spacing: BauhausDesign.space4,
              runSpacing: BauhausDesign.space4,
              children: [
                _buildActionTile(
                  width: tileWidth,
                  title: 'ENROLL\nPERSONNEL',
                  icon: Icons.person_add,
                  color: BauhausDesign.primary,
                  textColor: BauhausDesign.surfaceWhite,
                  onTap: () => debugPrint('Enroll Personnel tapped'),
                ),
                _buildActionTile(
                  width: tileWidth,
                  title: 'DEPLOY\nSHIFT',
                  icon: Icons.schedule,
                  color: BauhausDesign.accent,
                  textColor: BauhausDesign.textDark,
                  onTap: () => debugPrint('Deploy Shift tapped'),
                ),
                _buildActionTile(
                  width: tileWidth,
                  title: 'ARCHIVE\nREPORT',
                  icon: Icons.archive,
                  color: BauhausDesign.surfaceWhite,
                  textColor: BauhausDesign.textDark,
                  onTap: _exportReport,
                ),
                _buildActionTile(
                  width: tileWidth,
                  title: 'CONFIG\nSYSTEM',
                  icon: Icons.settings,
                  color: BauhausDesign.neutral,
                  textColor: BauhausDesign.surfaceWhite,
                  onTap: () => debugPrint('Config tapped'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space2),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite.withOpacity(0.2),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
              ),
              child: Icon(
                icon,
                color: BauhausDesign.surfaceWhite,
                size: 24,
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              title,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
        );
  }

  Widget _buildActionTile({
    required double width,
    required String title,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: textColor, size: 22),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              title,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftCard(ShiftDetail shift) {
    debugPrint('🔍 DEBUG: Processing shift with title: $shift');
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space2,
      ),
      child: BauhausCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shift.title,
                  style: BauhausDesign.getTextTheme(context).headlineMedium,
                ),
                _buildShiftStatusBadge(shift.status),
              ],
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              shift.employeeName,
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            ),
            if (shift.clientName != null) ...[
              const SizedBox(height: BauhausDesign.space1),
              Text(
                'Client: ${shift.clientName}',
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textMuted,
                      fontSize: 12,
                    ),
              ),
            ],
            const SizedBox(height: BauhausDesign.space2),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: BauhausDesign.textMuted,
                ),
                const SizedBox(width: BauhausDesign.space1),
                Text(
                  '${_formatTime(shift.startTime)} - ${_formatTime(shift.endTime)}',
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontSize: 12,
                          ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildShiftStatusBadge(ShiftStatus status) {
    Color color;
    String text;

    switch (status) {
      case ShiftStatus.scheduled:
        color = BauhausDesign.info;
        text = 'Scheduled';
        break;
      case ShiftStatus.inProgress:
        color = BauhausDesign.success;
        text = 'In Progress';
        break;
      case ShiftStatus.completed:
        color = BauhausDesign.textMuted;
        text = 'Completed';
        break;
      case ShiftStatus.cancelled:
        color = BauhausDesign.error;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        text,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: color,
            ),
      ),
    );
  }

  Color _statusColor(WorkStatus status) {
    switch (status) {
      case WorkStatus.active:
        return BauhausDesign.success;
      case WorkStatus.onBreak:
        return BauhausDesign.warning;
      case WorkStatus.offline:
      case WorkStatus.clockedOut:
        return BauhausDesign.textMuted;
    }
  }

  String _statusLabel(WorkStatus status) {
    switch (status) {
      case WorkStatus.active:
        return 'ACTIVE';
      case WorkStatus.onBreak:
        return 'ON BREAK';
      case WorkStatus.offline:
        return 'OFFLINE';
      case WorkStatus.clockedOut:
        return 'CLOCKED OUT';
    }
  }

  String _formatLastSeen(DateTime? lastSeen) {
    if (lastSeen == null) return 'No check-in';
    final now = DateTime.now();
    final diff = now.difference(lastSeen);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  String? _formatCoordinates(EmployeeStatus employee) {
    final lat = employee.liveLatitude;
    final lng = employee.liveLongitude;
    if (lat == null || lng == null) return null;
    return 'LAT ${lat.toStringAsFixed(4)} • LNG ${lng.toStringAsFixed(4)}';
  }

  Widget _buildLoadingState() {
    return const Center(
      child: BauhausLoadingState(message: 'Loading employee data...'),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: BauhausErrorState(
        message: error,
        onRetry: _refreshData,
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: BauhausEmptyState(
        title: 'No Data',
        subtitle: message,
        icon: Icons.people_outline,
      ),
    );
  }

  void _showEmployeeDetails(EmployeeStatus employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEmployeeDetailsBottomSheet(employee),
    );
  }

  Widget _buildEmployeeDetailsBottomSheet(EmployeeStatus employee) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(BauhausDesign.radiusLg),
          topRight: Radius.circular(BauhausDesign.radiusLg),
        ),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.textMuted,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmployeeStatusCard(
                    employee: employee,
                    showDetails: true,
                  ),
                  const SizedBox(height: BauhausDesign.space6),
                  Text(
                    'Recent Shifts',
                    style: BauhausDesign.getTextTheme(context).headlineMedium,
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  // Add shifts for this employee
                  ...ref
                      .read(employeeTrackingViewModelProvider.notifier)
                      .getEmployeeShifts(employee.id)
                      .map((shift) => _buildShiftCard(shift)),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1, end: 0, duration: 300.ms);
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(BauhausDesign.radiusLg),
            topRight: Radius.circular(BauhausDesign.radiusLg),
          ),
          border: Border.all(color: BauhausDesign.neutral, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Options',
              style: BauhausDesign.getTextTheme(context).headlineMedium,
            ),
            const SizedBox(height: BauhausDesign.space4),
            EmployeeFilterChips(
              selectedFilter: ref
                  .read(employeeTrackingViewModelProvider)
                  .value
                  ?.selectedFilter,
              onFilterChanged: (filter) {
                ref
                    .read(employeeTrackingViewModelProvider.notifier)
                    .setEmployeeFilter(filter);
                Navigator.pop(context);
              },
              statusCounts: ref.read(employeeStatusCountsProvider),
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],
        ),
      ),
    );
  }

  void _exportReport() {
    // Implement export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Export functionality coming soon!'),
        backgroundColor: BauhausDesign.info,
      ),
    );
  }

  Future<void> _navigateToAssignTab() async {
    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init();

    final userEmail =
        await sharedPrefs.getUserEmailFromSharedPreferences() ?? '';
    final role = sharedPrefs.getRole() ?? UserRole.admin;
    final organizationId = sharedPrefs.getOrganizationId() ?? '';
    final organizationName = sharedPrefs.getString('organizationName') ?? '';
    final organizationCode = sharedPrefs.getOrganizationCode() ?? '';

    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.bottomNavBar,
      (route) => false,
      arguments: {
        'email': userEmail,
        'role': role,
        'organizationId': organizationId,
        'organizationName': organizationName,
        'organizationCode': organizationCode,
        'initialIndex': role == UserRole.admin ? 1 : 0,
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class _LiveZoneMap extends StatefulWidget {
  final List<EmployeeStatus> employees;

  const _LiveZoneMap({required this.employees});

  @override
  State<_LiveZoneMap> createState() => _LiveZoneMapState();
}

class _LiveZoneMapState extends State<_LiveZoneMap> {
  google_maps.GoogleMapController? _googleController;

  @override
  void didUpdateWidget(covariant _LiveZoneMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.employees, widget.employees)) {
      _fitMarkers();
    }
  }

  @override
  void dispose() {
    _googleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.employees.isEmpty) {
      return const SizedBox.shrink();
    }

    final center = _computeCenter();

    return ClipRRect(
      borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: defaultTargetPlatform == TargetPlatform.iOS
            ? _buildAppleMap(center)
            : _buildGoogleMap(center),
      ),
    );
  }

  Widget _buildGoogleMap(google_maps.LatLng center) {
    final markers = widget.employees
        .where((e) => e.liveLatitude != null && e.liveLongitude != null)
        .map(
          (employee) => google_maps.Marker(
            markerId: google_maps.MarkerId(employee.email),
            position: google_maps.LatLng(
              employee.liveLatitude!,
              employee.liveLongitude!,
            ),
            infoWindow: google_maps.InfoWindow(
              title: employee.name,
              snippet: employee.liveClientName ?? employee.currentLocation,
            ),
          ),
        )
        .toSet();

    return google_maps.GoogleMap(
      initialCameraPosition: google_maps.CameraPosition(
        target: center,
        zoom: 14,
      ),
      markers: markers,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      liteModeEnabled: false,
      onMapCreated: (controller) {
        _googleController = controller;
        _fitMarkers();
      },
    );
  }

  Widget _buildAppleMap(google_maps.LatLng center) {
    final annotations = widget.employees
        .where((e) => e.liveLatitude != null && e.liveLongitude != null)
        .map(
          (employee) => apple_maps.Annotation(
            annotationId: apple_maps.AnnotationId(employee.email),
            position: apple_maps.LatLng(
              employee.liveLatitude!,
              employee.liveLongitude!,
            ),
          ),
        )
        .toSet();

    return apple_maps.AppleMap(
      initialCameraPosition: apple_maps.CameraPosition(
        target: apple_maps.LatLng(center.latitude, center.longitude),
        zoom: 14,
      ),
      annotations: annotations,
      myLocationEnabled: false,
    );
  }

  google_maps.LatLng _computeCenter() {
    if (widget.employees.isEmpty) {
      return const google_maps.LatLng(-37.8136, 144.9631);
    }

    double latSum = 0;
    double lngSum = 0;
    int count = 0;

    for (final employee in widget.employees) {
      final lat = employee.liveLatitude;
      final lng = employee.liveLongitude;
      if (lat == null || lng == null) continue;
      latSum += lat;
      lngSum += lng;
      count += 1;
    }

    if (count == 0) {
      return const google_maps.LatLng(-37.8136, 144.9631);
    }

    return google_maps.LatLng(latSum / count, lngSum / count);
  }

  void _fitMarkers() {
    if (_googleController == null || widget.employees.isEmpty) return;

    final liveEmployees = widget.employees
        .where((e) => e.liveLatitude != null && e.liveLongitude != null)
        .toList();
    if (liveEmployees.isEmpty) return;

    if (liveEmployees.length == 1) {
      _googleController?.animateCamera(
        google_maps.CameraUpdate.newLatLngZoom(
          google_maps.LatLng(
            liveEmployees.first.liveLatitude!,
            liveEmployees.first.liveLongitude!,
          ),
          15,
        ),
      );
      return;
    }

    double minLat = liveEmployees.first.liveLatitude!;
    double maxLat = liveEmployees.first.liveLatitude!;
    double minLng = liveEmployees.first.liveLongitude!;
    double maxLng = liveEmployees.first.liveLongitude!;

    for (final employee in liveEmployees) {
      minLat = employee.liveLatitude! < minLat ? employee.liveLatitude! : minLat;
      maxLat = employee.liveLatitude! > maxLat ? employee.liveLatitude! : maxLat;
      minLng = employee.liveLongitude! < minLng ? employee.liveLongitude! : minLng;
      maxLng = employee.liveLongitude! > maxLng ? employee.liveLongitude! : maxLng;
    }

    final bounds = google_maps.LatLngBounds(
      southwest: google_maps.LatLng(minLat, minLng),
      northeast: google_maps.LatLng(maxLat, maxLng),
    );

    _googleController?.animateCamera(
      google_maps.CameraUpdate.newLatLngBounds(bounds, 48),
    );
  }
}
