import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
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
            EmployeeStatsOverview(
              stats: stats,
              onRefresh: _refreshData,
              isLoading: state.isRefreshing,
            ),
            const SizedBox(height: BauhausDesign.space6),
            _buildRecentActivitySection(state),
            const SizedBox(height: BauhausDesign.space6),
            _buildQuickActionsSection(),
            const SizedBox(height: BauhausDesign.space6),
          ],
        ),
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
        Text(
          'Recent Activity',
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(height: BauhausDesign.space4),
        BauhausCard(
          padding: const EdgeInsets.all(BauhausDesign.space4),
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
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(height: BauhausDesign.space4),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Add Employee',
                Icons.person_add,
                BauhausDesign.primary,
                () => debugPrint('Add Employee tapped'),
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: _buildQuickActionCard(
                'Schedule Shift',
                Icons.schedule,
                BauhausDesign.info,
                () => debugPrint('Schedule Shift tapped'),
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space4),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Export Report',
                Icons.file_download,
                BauhausDesign.success,
                () => _exportReport(),
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: _buildQuickActionCard(
                'Settings',
                Icons.settings,
                BauhausDesign.textMuted,
                () => debugPrint('Settings tapped'),
              ),
            ),
          ],
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

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
