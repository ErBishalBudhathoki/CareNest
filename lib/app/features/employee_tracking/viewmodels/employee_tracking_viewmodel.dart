
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/employee_tracking_model.dart';
import '../repositories/employee_tracking_repository.dart';

// Provider for the repository
final employeeTrackingRepositoryProvider =
    Provider<EmployeeTrackingRepository>((ref) {
  return EmployeeTrackingRepository();
});

// Provider for the ViewModel
final employeeTrackingViewModelProvider = StateNotifierProvider<
    EmployeeTrackingViewModel, AsyncValue<EmployeeTrackingState>>((ref) {
  final repository = ref.watch(employeeTrackingRepositoryProvider);
  return EmployeeTrackingViewModel(repository);
});

// Provider for filtered employees based on status
final filteredEmployeesProvider =
    Provider.family<List<EmployeeStatus>, WorkStatus?>((ref, status) {
  final trackingState = ref.watch(employeeTrackingViewModelProvider);

  return trackingState.when(
    data: (state) {
      if (status == null) {
        return state.data.employees;
      }
      return state.data.employees
          .where((employee) => employee.status == status)
          .toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// Provider for employee statistics
final employeeStatsProvider = Provider<Map<String, int>>((ref) {
  final trackingState = ref.watch(employeeTrackingViewModelProvider);

  return trackingState.when(
    data: (state) => {
      'total': state.data.totalEmployees,
      'active': state.data.activeEmployees,
      'onBreak': state.data.onBreakEmployees,
      'offline': state.data.offlineEmployees,
    },
    loading: () => {'total': 0, 'active': 0, 'onBreak': 0, 'offline': 0},
    error: (_, __) => {'total': 0, 'active': 0, 'onBreak': 0, 'offline': 0},
  );
});

// Provider for employee status counts (for EmployeeFilterChips)
final employeeStatusCountsProvider = Provider<Map<WorkStatus, int>>((ref) {
  final trackingState = ref.watch(employeeTrackingViewModelProvider);

  return trackingState.when(
    data: (state) => {
      WorkStatus.active: state.data.activeEmployees,
      WorkStatus.onBreak: state.data.onBreakEmployees,
      WorkStatus.offline: state.data.offlineEmployees,
    },
    loading: () => {
      WorkStatus.active: 0,
      WorkStatus.onBreak: 0,
      WorkStatus.offline: 0,
    },
    error: (_, __) => {
      WorkStatus.active: 0,
      WorkStatus.onBreak: 0,
      WorkStatus.offline: 0,
    },
  );
});

class EmployeeTrackingState {
  final EmployeeTrackingData data;
  final WorkStatus? selectedFilter;
  final bool isRefreshing;
  final DateTime lastUpdated;

  EmployeeTrackingState({
    required this.data,
    this.selectedFilter,
    this.isRefreshing = false,
    required this.lastUpdated,
  });

  EmployeeTrackingState copyWith({
    EmployeeTrackingData? data,
    WorkStatus? selectedFilter,
    bool? isRefreshing,
    DateTime? lastUpdated,
    bool clearSelectedFilter = false,
  }) {
    return EmployeeTrackingState(
      data: data ?? this.data,
      selectedFilter:
          clearSelectedFilter ? null : (selectedFilter ?? this.selectedFilter),
      isRefreshing: isRefreshing ?? this.isRefreshing,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class EmployeeTrackingViewModel
    extends StateNotifier<AsyncValue<EmployeeTrackingState>> {
  final EmployeeTrackingRepository _repository;

  EmployeeTrackingViewModel(this._repository)
      : super(const AsyncValue.loading()) {
    loadEmployeeTrackingData();
  }

  /// Loads employee tracking data from the repository
  Future<void> loadEmployeeTrackingData() async {
    debugPrint(
        '🔍 DEBUG: EmployeeTrackingViewModel.loadEmployeeTrackingData() called');

    try {
      state = const AsyncValue.loading();
      debugPrint('🔍 DEBUG: State set to loading, fetching data from repository...');

      final data = await _repository.getEmployeeTrackingData();
      debugPrint('🔍 DEBUG: Data fetched successfully from repository');
      debugPrint('🔍 DEBUG: Employee count: ${data.employees.length}');
      debugPrint('🔍 DEBUG: Active employees: ${data.activeEmployees}');
      debugPrint('🔍 DEBUG: Total employees: ${data.totalEmployees}');

      state = AsyncValue.data(EmployeeTrackingState(
        data: data,
        selectedFilter: null, // Start with 'All' filter selected
        lastUpdated: DateTime.now(),
      ));
      debugPrint('🔍 DEBUG: State updated with employee tracking data');
    } catch (error, stackTrace) {
      debugPrint('🔍 DEBUG: Error loading employee tracking data: $error');
      debugPrint('🔍 DEBUG: Stack trace: $stackTrace');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refreshes employee tracking data
  Future<void> refreshEmployeeTrackingData() async {
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncValue.data(currentState.copyWith(isRefreshing: true));
    }

    try {
      final data = await _repository.refreshEmployeeTrackingData();

      state = AsyncValue.data(EmployeeTrackingState(
        data: data,
        selectedFilter: currentState?.selectedFilter,
        isRefreshing: false,
        lastUpdated: DateTime.now(),
      ));
    } catch (e) {
      if (currentState != null) {
        state = AsyncValue.data(currentState.copyWith(isRefreshing: false));
      }
      // You might want to show a snackbar or toast here
      rethrow;
    }
  }

  /// Sets the filter for employees
  void setEmployeeFilter(WorkStatus? filter) {
    final currentState = state.value;
    if (currentState != null) {
      if (filter == null) {
        state =
            AsyncValue.data(currentState.copyWith(clearSelectedFilter: true));
      } else {
        state = AsyncValue.data(currentState.copyWith(selectedFilter: filter));
      }
    }
  }

  /// Updates employee status
  Future<void> updateEmployeeStatus(
      String employeeId, WorkStatus status) async {
    try {
      final success =
          await _repository.updateEmployeeStatus(employeeId, status);
      if (success) {
        // Refresh data to get updated status
        await refreshEmployeeTrackingData();
      }
    } catch (e) {
      // Handle error - you might want to show a snackbar
      rethrow;
    }
  }

  /// Gets filtered employees based on current filter
  List<EmployeeStatus> getFilteredEmployees() {
    final currentState = state.value;
    if (currentState == null) return [];

    if (currentState.selectedFilter == null) {
      return currentState.data.employees;
    }

    return currentState.data.employees
        .where((employee) => employee.status == currentState.selectedFilter)
        .toList();
  }

  /// Gets employee by ID
  EmployeeStatus? getEmployeeById(String employeeId) {
    final currentState = state.value;
    if (currentState == null) return null;

    try {
      return currentState.data.employees
          .firstWhere((employee) => employee.id == employeeId);
    } catch (e) {
      return null;
    }
  }

  /// Gets shifts for a specific employee
  List<ShiftDetail> getEmployeeShifts(String employeeId) {
    final currentState = state.value;
    if (currentState == null) return [];

    return currentState.data.shifts
        .where((shift) => shift.employeeId == employeeId)
        .toList();
  }

  /// Gets assignments for a specific employee
  List<ClientAssignment> getEmployeeAssignments(String employeeId) {
    final currentState = state.value;
    if (currentState == null) return [];

    return currentState.data.assignments
        .where((assignment) => assignment.employeeId == employeeId)
        .toList();
  }
}
