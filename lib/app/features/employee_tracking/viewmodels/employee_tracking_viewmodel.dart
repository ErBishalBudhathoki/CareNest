import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/employee_tracking_model.dart';
import '../repositories/employee_tracking_repository.dart';

// Provider for the repository
final employeeTrackingRepositoryProvider = Provider<EmployeeTrackingRepository>(
  (ref) {
    return EmployeeTrackingRepository(
      apiMethod: ref.read(app_providers.apiMethodProvider),
    );
  },
);

// Provider for the ViewModel
final employeeTrackingViewModelProvider =
    AsyncNotifierProvider<EmployeeTrackingViewModel, EmployeeTrackingState>(
      EmployeeTrackingViewModel.new,
    );

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
        error: (_, _) => [],
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
    error: (_, _) => {'total': 0, 'active': 0, 'onBreak': 0, 'offline': 0},
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
    error: (_, _) => {
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
      selectedFilter: clearSelectedFilter
          ? null
          : (selectedFilter ?? this.selectedFilter),
      isRefreshing: isRefreshing ?? this.isRefreshing,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class EmployeeTrackingViewModel extends AsyncNotifier<EmployeeTrackingState> {
  late final EmployeeTrackingRepository _repository;

  @override
  Future<EmployeeTrackingState> build() async {
    _repository = ref.watch(employeeTrackingRepositoryProvider);
    return _loadInitialData();
  }

  Future<EmployeeTrackingState> _loadInitialData() async {
    final data = await _repository.getEmployeeTrackingData();
    return EmployeeTrackingState(
      data: data,
      selectedFilter: null,
      lastUpdated: DateTime.now(),
    );
  }

  Future<void> loadEmployeeTrackingData() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadInitialData);
  }

  /// Refreshes employee tracking data
  Future<void> refreshEmployeeTrackingData() async {
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(isRefreshing: true));
    }

    try {
      final data = await _repository.refreshEmployeeTrackingData();

      state = AsyncValue.data(
        EmployeeTrackingState(
          data: data,
          selectedFilter: currentState?.selectedFilter,
          isRefreshing: false,
          lastUpdated: DateTime.now(),
        ),
      );
    } catch (e) {
      if (currentState != null) {
        state = AsyncData(currentState.copyWith(isRefreshing: false));
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
        state = AsyncValue.data(
          currentState.copyWith(clearSelectedFilter: true),
        );
      } else {
        state = AsyncData(currentState.copyWith(selectedFilter: filter));
      }
    }
  }

  /// Updates employee status
  Future<void> updateEmployeeStatus(
    String employeeId,
    WorkStatus status,
  ) async {
    try {
      final success = await _repository.updateEmployeeStatus(
        employeeId,
        status,
      );
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
      return currentState.data.employees.firstWhere(
        (employee) => employee.id == employeeId,
      );
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
