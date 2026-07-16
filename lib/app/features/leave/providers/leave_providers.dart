import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class LeaveForecastNotifier extends AsyncNotifier<Map<String, dynamic>?> {
  late final LeaveRepository _repository;
  
  @override
  FutureOr<Map<String, dynamic>?> build() {
    _repository = ref.watch(leaveRepositoryProvider);
    return null;
  }

  Future<void> fetchForecast(String email, DateTime targetDate) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await _repository.getLeaveForecast(email, targetDate);
      if (result['success'] == true) {
        return result['data'];
      } else {
        throw Exception(result['message'] ?? 'Failed to load forecast');
      }
    });
  }
}

final leaveForecastProvider = AsyncNotifierProvider<LeaveForecastNotifier, Map<String, dynamic>?>(LeaveForecastNotifier.new);
