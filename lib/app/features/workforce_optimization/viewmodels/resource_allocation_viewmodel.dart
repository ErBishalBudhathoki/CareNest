import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/workforce_optimization/models/workforce_models.dart';
import 'package:carenest/app/features/workforce_optimization/repositories/workforce_repository.dart';
import 'package:carenest/app/features/workforce_optimization/viewmodels/workforce_planning_viewmodel.dart';

// State class for Resource Allocation
class ResourceAllocationState {
  late final bool isLoading;
  late final List<ResourceAllocation> allocations;
  late final AllocationMetrics? metrics;
  late final List<WorkerRecommendation> recommendations;
  late final List<WorkloadAnalysis> workloadAnalysis;
  late final String? error;

  ResourceAllocationState({
    this.isLoading = false,
    this.allocations = const [],
    this.metrics,
    this.recommendations = const [],
    this.workloadAnalysis = const [],
    this.error,
  });

  ResourceAllocationState copyWith({
    bool? isLoading,
    List<ResourceAllocation>? allocations,
    AllocationMetrics? metrics,
    List<WorkerRecommendation>? recommendations,
    List<WorkloadAnalysis>? workloadAnalysis,
    String? error,
  }) {
    return ResourceAllocationState(
      isLoading: isLoading ?? this.isLoading,
      allocations: allocations ?? this.allocations,
      metrics: metrics ?? this.metrics,
      recommendations: recommendations ?? this.recommendations,
      workloadAnalysis: workloadAnalysis ?? this.workloadAnalysis,
      error: error,
    );
  }
}

// StateNotifier for Resource Allocation
class ResourceAllocationViewModel extends Notifier<ResourceAllocationState> {
  late final WorkforceRepository _repository;

  
  @override
  ResourceAllocationState build() {
    final repository = ref.watch(workforceRepositoryProvider);
    
    return ResourceAllocationState();
  }

  // Optimize allocation
  Future<void> optimizeAllocation({
    required String organizationId,
    required String date,
    List<Map<String, dynamic>>? appointments,
    Map<String, dynamic>? constraints,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.optimizeAllocation(
        organizationId: organizationId,
        date: date,
        appointments: appointments,
        constraints: constraints,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          allocations: result['allocations'] as List<ResourceAllocation>,
          metrics: result['metrics'] as AllocationMetrics?,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Reallocate resources
  Future<void> reallocateResources({
    required String organizationId,
    required String triggerId,
    required String reason,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.reallocateResources(
        organizationId: organizationId,
        triggerId: triggerId,
        reason: reason,
      );

      if (result['success'] == true) {
        // Refresh allocations after reallocation
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Get allocation recommendations
  Future<void> getAllocationRecommendations({
    required String appointmentId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getAllocationRecommendations(
        appointmentId: appointmentId,
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          recommendations: result['recommendations'] as List<WorkerRecommendation>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Analyze workload balance
  Future<void> analyzeWorkloadBalance({
    required String organizationId,
    required String startDate,
    required String endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.analyzeWorkloadBalance(
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (result['success'] == true) {
        state = state.copyWith(
          isLoading: false,
          workloadAnalysis: result['workloads'] as List<WorkloadAnalysis>,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result['message'] as String?,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Reset state
  void reset() {
    state = ResourceAllocationState();
  }
}

// Provider for ResourceAllocationViewModel
final resourceAllocationViewModelProvider = NotifierProvider<ResourceAllocationViewModel, ResourceAllocationState>(ResourceAllocationViewModel.new);
