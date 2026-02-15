import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shift_model.dart';

import '../repositories/schedule_repository.dart';

final scheduleViewModelProvider =
    StateNotifierProvider.family<ScheduleViewModel, ScheduleState, String>(
        (ref, organizationId) {
  final repository = ref.watch(scheduleRepositoryProvider);
  return ScheduleViewModel(repository, organizationId);
});

class ScheduleState {
  final AsyncValue<List<ShiftModel>> shifts;
  final DateTime selectedDate;
  final String selectedFilter;

  const ScheduleState({
    this.shifts = const AsyncValue.loading(),
    required this.selectedDate,
    this.selectedFilter = 'all',
  });

  ScheduleState copyWith({
    AsyncValue<List<ShiftModel>>? shifts,
    DateTime? selectedDate,
    String? selectedFilter,
  }) {
    return ScheduleState(
      shifts: shifts ?? this.shifts,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class ScheduleViewModel extends StateNotifier<ScheduleState> {
  final ScheduleRepository _repository;
  final String _organizationId;

  ScheduleViewModel(this._repository, this._organizationId)
      : super(ScheduleState(selectedDate: DateTime.now())) {
    loadShifts();
  }

  Future<void> loadShifts() async {
    // Calculate week range based on selected date
    final startOfWeek = state.selectedDate
        .subtract(Duration(days: state.selectedDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    state = state.copyWith(shifts: const AsyncValue.loading());

    try {
      final shifts = await _repository.getShifts(
        organizationId: _organizationId,
        startDate: startOfWeek,
        endDate: endOfWeek,
        status: state.selectedFilter == 'all' ? null : state.selectedFilter,
      );
      if (mounted) {
        state = state.copyWith(shifts: AsyncValue.data(shifts));
      }
    } catch (e, st) {
      if (mounted) {
        state = state.copyWith(shifts: AsyncValue.error(e, st));
      }
    }
  }

  void updateDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
    loadShifts();
  }

  void updateFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
    loadShifts();
  }

  Future<void> createShift(Map<String, dynamic> shiftData) async {
    await _repository.createShift(shiftData);
    await loadShifts();
  }

  Future<void> updateShift(String shiftId, Map<String, dynamic> updates) async {
    await _repository.updateShift(shiftId, updates);
    await loadShifts();
  }
}
