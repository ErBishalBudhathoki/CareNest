import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/themes/app_theme_config.dart';
import 'package:carenest/app/shared/design_system/modern_pricing_design_system.dart';
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
      backgroundColor: AppColors.colorBackground,
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
          gradient: LinearGradient(
            colors: ModernPricingDesign.primaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      title: Text(
        'Employee Tracking',
        style: ModernPricingDesign.headingLg.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        ModernActionButton(
          icon: Icons.refresh,
          onPressed: () => _refreshData(),
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          textColor: Colors.white,
          padding: const EdgeInsets.all(ModernPricingDesign.spacingSm),
          borderRadius: ModernPricingDesign.radiusRound,
        ),
        const SizedBox(width: ModernPricingDesign.spacingSm),
        ModernActionButton(
          icon: Icons.filter_list,
          onPressed: () => _showFilterBottomSheet(),
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          textColor: Colors.white,
          padding: const EdgeInsets.all(ModernPricingDesign.spacingSm),
          borderRadius: ModernPricingDesign.radiusRound,
        ),
        const SizedBox(width: ModernPricingDesign.spacingMd),
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
        labelStyle: ModernPricingDesign.bodyMd.copyWith(
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
      color: AppColors.colorPrimary,
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
        padding: const EdgeInsets.all(ModernPricingDesign.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmployeeStatsOverview(
              stats: stats,
              onRefresh: _refreshData,
              isLoading: state.isRefreshing,
            ),
            const SizedBox(height: ModernPricingDesign.spacingXl),
            _buildRecentActivitySection(state),
            const SizedBox(height: ModernPricingDesign.spacingXl),
            _buildQuickActionsSection(),
            const SizedBox(height: ModernPricingDesign.spacingXl),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeesTab(
      EmployeeTrackingState state, Map<String, int> stats) {
    return Column(
      children: [
        const SizedBox(height: AppThemeConfig.spacingM),
        EmployeeFilterChips(
          selectedFilter: state.selectedFilter,
          onFilterChanged: (filter) {
            ref
                .read(employeeTrackingViewModelProvider.notifier)
                .setEmployeeFilter(filter);
          },
          statusCounts: ref.watch(employeeStatusCountsProvider),
        ),
        const SizedBox(height: AppThemeConfig.spacingM),
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
          const SizedBox(height: AppThemeConfig.spacingM),
          ...state.data.shifts.map((shift) => _buildShiftCard(shift)),
          const SizedBox(height: AppThemeConfig.spacingXXL),
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
          style: ModernPricingDesign.headingMd.copyWith(
            fontWeight: FontWeight.w700,
            color: ModernPricingDesign.textPrimary,
          ),
        ),
        const SizedBox(height: ModernPricingDesign.spacingMd),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ModernPricingDesign.radiusLg),
            border: Border.all(color: ModernPricingDesign.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(ModernPricingDesign.spacingLg),
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
          style: ModernPricingDesign.headingMd.copyWith(
            fontWeight: FontWeight.w700,
            color: ModernPricingDesign.textPrimary,
          ),
        ),
        const SizedBox(height: ModernPricingDesign.spacingMd),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Add Employee',
                Icons.person_add,
                ModernPricingDesign.primaryGradient,
                () => debugPrint('Add Employee tapped'),
              ),
            ),
            const SizedBox(width: ModernPricingDesign.spacingMd),
            Expanded(
              child: _buildQuickActionCard(
                'Schedule Shift',
                Icons.schedule,
                ModernPricingDesign.infoGradient,
                () => debugPrint('Schedule Shift tapped'),
              ),
            ),
          ],
        ),
        const SizedBox(height: ModernPricingDesign.spacingMd),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Export Report',
                Icons.file_download,
                ModernPricingDesign.successGradient,
                () => _exportReport(),
              ),
            ),
            const SizedBox(width: ModernPricingDesign.spacingMd),
            Expanded(
              child: _buildQuickActionCard(
                'Settings',
                Icons.settings,
                [
                  ModernPricingDesign.textSecondary,
                  ModernPricingDesign.textTertiary
                ],
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
    List<Color> gradientColors,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ModernPricingDesign.spacingLg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(ModernPricingDesign.radiusLg),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(ModernPricingDesign.spacingSm),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius:
                    BorderRadius.circular(ModernPricingDesign.radiusRound),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: ModernPricingDesign.spacingSm),
            Text(
              title,
              style: ModernPricingDesign.bodyMd.copyWith(
                color: Colors.white,
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
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppThemeConfig.spacingM,
        vertical: AppThemeConfig.spacingS,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppThemeConfig.borderRadiusM,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppThemeConfig.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shift.title,
                  style: AppThemeConfig.titleStyle.copyWith(
                    fontSize: AppThemeConfig.fontSizeLarge,
                  ),
                ),
                _buildShiftStatusBadge(shift.status),
              ],
            ),
            const SizedBox(height: AppThemeConfig.spacingS),
            Text(
              shift.employeeName,
              style: AppThemeConfig.bodyStyle,
            ),
            if (shift.clientName != null) ...[
              const SizedBox(height: AppThemeConfig.spacingXS),
              Text(
                'Client: ${shift.clientName}',
                style: AppThemeConfig.captionStyle,
              ),
            ],
            const SizedBox(height: AppThemeConfig.spacingS),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppColors.colorGrey600,
                ),
                const SizedBox(width: AppThemeConfig.spacingXS),
                Text(
                  '${_formatTime(shift.startTime)} - ${_formatTime(shift.endTime)}',
                  style: AppThemeConfig.captionStyle,
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
        color = AppColors.colorBlue;
        text = 'Scheduled';
        break;
      case ShiftStatus.inProgress:
        color = AppColors.colorSuccess;
        text = 'In Progress';
        break;
      case ShiftStatus.completed:
        color = AppColors.colorGrey600;
        text = 'Completed';
        break;
      case ShiftStatus.cancelled:
        color = AppColors.error;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConfig.spacingS,
        vertical: AppThemeConfig.spacingXS,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppThemeConfig.borderRadiusS,
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: AppThemeConfig.captionStyle.copyWith(
          color: color,
          fontWeight: AppThemeConfig.fontWeightMedium,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.colorPrimary),
          SizedBox(height: AppThemeConfig.spacingM),
          Text(
            'Loading employee data...',
            style: AppThemeConfig.bodyStyle,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error,
          ).animate().shake(duration: 500.ms),
          const SizedBox(height: AppThemeConfig.spacingM),
          Text(
            'Error loading data',
            style: AppThemeConfig.titleStyle.copyWith(
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppThemeConfig.spacingS),
          Text(
            error,
            style: AppThemeConfig.captionStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppThemeConfig.spacingL),
          ElevatedButton(
            onPressed: _refreshData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
              foregroundColor: AppColors.colorWhite,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: AppColors.colorGrey400,
          ).animate().scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.0, 1.0),
              duration: 500.ms),
          const SizedBox(height: AppThemeConfig.spacingM),
          Text(
            message,
            style: AppThemeConfig.bodyStyle.copyWith(
              color: AppColors.colorGrey600,
            ),
          ),
        ],
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
      decoration: const BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppThemeConfig.radiusL),
          topRight: Radius.circular(AppThemeConfig.radiusL),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin:
                const EdgeInsets.symmetric(vertical: AppThemeConfig.spacingS),
            decoration: BoxDecoration(
              color: AppColors.colorGrey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppThemeConfig.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmployeeStatusCard(
                    employee: employee,
                    showDetails: true,
                  ),
                  const SizedBox(height: AppThemeConfig.spacingL),
                  Text(
                    'Recent Shifts',
                    style: AppThemeConfig.titleStyle,
                  ),
                  const SizedBox(height: AppThemeConfig.spacingM),
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
        padding: const EdgeInsets.all(AppThemeConfig.spacingL),
        decoration: const BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppThemeConfig.radiusL),
            topRight: Radius.circular(AppThemeConfig.radiusL),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Options',
              style: AppThemeConfig.titleStyle,
            ),
            const SizedBox(height: AppThemeConfig.spacingL),
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
            const SizedBox(height: AppThemeConfig.spacingL),
          ],
        ),
      ),
    );
  }

  void _exportReport() {
    // Implement export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export functionality coming soon!'),
        backgroundColor: AppColors.colorInfo,
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
