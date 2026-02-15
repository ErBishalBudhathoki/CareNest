import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/scheduling/models/shift_matching_models.dart';
import 'package:carenest/app/features/scheduling/repositories/scheduling_repository.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

/// State for shift matching
class ShiftMatchingState {
  final bool isLoading;
  final String? error;
  final List<WorkerMatch> matches;
  final AutoFillResult? autoFillResult;
  final RouteOptimization? routeOptimization;
  final ShiftRecommendation? shiftRecommendation;

  ShiftMatchingState({
    this.isLoading = false,
    this.error,
    this.matches = const [],
    this.autoFillResult,
    this.routeOptimization,
    this.shiftRecommendation,
  });

  ShiftMatchingState copyWith({
    bool? isLoading,
    String? error,
    List<WorkerMatch>? matches,
    AutoFillResult? autoFillResult,
    RouteOptimization? routeOptimization,
    ShiftRecommendation? shiftRecommendation,
  }) {
    return ShiftMatchingState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      matches: matches ?? this.matches,
      autoFillResult: autoFillResult ?? this.autoFillResult,
      routeOptimization: routeOptimization ?? this.routeOptimization,
      shiftRecommendation: shiftRecommendation ?? this.shiftRecommendation,
    );
  }
}

class ShiftMatchingViewModel extends StateNotifier<ShiftMatchingState> {
  final SchedulingRepository _repository;

  ShiftMatchingViewModel(this._repository) : super(ShiftMatchingState());

  /// Match workers to a shift
  Future<void> matchWorkers({
    required String shiftId,
    required String organizationId,
    MatchingCriteria? criteria,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final matches = await _repository.matchWorkers(
        shiftId: shiftId,
        organizationId: organizationId,
        criteria: criteria,
      );
      state = state.copyWith(
        isLoading: false,
        matches: matches,
      );
    } catch (e) {
      debugPrint('Error in matchWorkers: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        matches: [],
      );
    }
  }

  /// Auto-fill multiple shifts
  Future<void> autoFillShifts({
    required List<String> shiftIds,
    required String organizationId,
    MatchingCriteria? criteria,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final autoFillResult = await _repository.autoFillShifts(
        shiftIds: shiftIds,
        organizationId: organizationId,
        criteria: criteria,
      );
      state = state.copyWith(
        isLoading: false,
        autoFillResult: autoFillResult,
      );
    } catch (e) {
      debugPrint('Error in autoFillShifts: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Optimize route for a worker
  Future<void> optimizeRoute({
    required String workerId,
    required DateTime date,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final routeOptimization = await _repository.optimizeRoute(
        workerId: workerId,
        date: date,
        organizationId: organizationId,
      );
      state = state.copyWith(
        isLoading: false,
        routeOptimization: routeOptimization,
      );
    } catch (e) {
      debugPrint('Error in optimizeRoute: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Get shift recommendations
  Future<void> getShiftRecommendations({
    required String shiftId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final shiftRecommendation = await _repository.getShiftRecommendations(
        shiftId: shiftId,
        organizationId: organizationId,
      );
      state = state.copyWith(
        isLoading: false,
        shiftRecommendation: shiftRecommendation,
      );
    } catch (e) {
      debugPrint('Error in getShiftRecommendations: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Reset state
  void reset() {
    state = ShiftMatchingState();
  }
}

/// Provider for shift matching viewmodel
final shiftMatchingViewModelProvider =
    StateNotifierProvider<ShiftMatchingViewModel, ShiftMatchingState>((ref) {
  final apiMethod = ref.watch(apiMethodProvider);
  final repository = SchedulingRepository(apiMethod);
  return ShiftMatchingViewModel(repository);
});
