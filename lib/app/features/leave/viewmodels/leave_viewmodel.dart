import 'package:carenest/app/features/leave/providers/leave_providers.dart';
import 'package:carenest/app/features/leave/repositories/leave_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaveViewModelState {
  final bool isLoading;
  final String? errorMessage;
  final List<dynamic> holidays;

  LeaveViewModelState({
    this.isLoading = false,
    this.errorMessage,
    this.holidays = const [],
  });

  LeaveViewModelState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<dynamic>? holidays,
  }) {
    return LeaveViewModelState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      holidays: holidays ?? this.holidays,
    );
  }
}

class LeaveViewModel extends Notifier<LeaveViewModelState> {
  late final String _userEmail;
  late final LeaveRepository _repository;

  LeaveViewModel(this._userEmail);

  @override
  LeaveViewModelState build() {
    _repository = ref.watch(leaveRepositoryProvider);
    return LeaveViewModelState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await Future.wait([
        ref.refresh(leaveBalancesProvider(_userEmail).future),
        ref.refresh(leaveRequestsProvider(_userEmail).future),
      ]);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> submitRequest({
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    required double totalHours,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final result = await _repository.submitLeaveRequest(
        userEmail: _userEmail,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        totalHours: totalHours,
      );

      if (result['success'] == true) {
        await refresh();
        return true;
      } else {
        state = state.copyWith(errorMessage: result['message'] ?? 'Failed to submit request');
        return false;
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadForecast(DateTime targetDate) async {
    await ref.read(leaveForecastProvider.notifier).fetchForecast(_userEmail, targetDate);
  }

  Future<double> calculateLeaveHours(DateTime startDate, DateTime endDate) async {
    try {
      final result = await _repository.calculateLeaveHours(
        startDate: startDate,
        endDate: endDate,
      );
      
      if (result['success'] == true && result['data'] != null) {
        final data = result['data'];
        return (data['totalHours'] as num).toDouble();
      }
      return 0.0;
    } catch (e) {
      debugPrint('Error calculating hours: $e');
      return 0.0;
    }
  }

  Future<void> fetchHolidays({String? organizationId}) async {
    try {
      final holidays = await _repository.getHolidays(organizationId: organizationId);
      state = state.copyWith(holidays: holidays);
    } catch (e) {
      debugPrint('Error fetching holidays: $e');
    }
  }
}

final leaveViewModelProvider = NotifierProvider.family<LeaveViewModel, LeaveViewModelState, String>(LeaveViewModel.new);
