import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
import 'package:carenest/app/features/leave/repositories/leave_repository.dart';
import 'package:carenest/app/features/leave/models/leave_balance.dart';
import 'package:carenest/app/features/leave/models/leave_request_model.dart';

final leaveRepositoryProvider = Provider<LeaveRepository>((ref) {
  return LeaveRepository(ref.read(app_providers.apiMethodProvider));
});

final leaveBalancesProvider = FutureProvider.family<LeaveBalance?, String>((ref, email) async {
  return ref.read(leaveRepositoryProvider).getLeaveBalances(email);
});

final leaveRequestsProvider = FutureProvider.family<List<LeaveRequest>, String>((ref, email) async {
  return ref.read(leaveRepositoryProvider).getUserLeaveRequests(email);
});

class LeaveForecastNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  final LeaveRepository _repository;
  
  LeaveForecastNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> fetchForecast(String email, DateTime targetDate) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.getLeaveForecast(email, targetDate);
      if (result['success'] == true) {
        state = AsyncValue.data(result['data']);
      } else {
        state = AsyncValue.error(result['message'] ?? 'Failed to load forecast', StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final leaveForecastProvider = StateNotifierProvider<LeaveForecastNotifier, AsyncValue<Map<String, dynamic>?>>((ref) {
  return LeaveForecastNotifier(ref.read(leaveRepositoryProvider));
});
