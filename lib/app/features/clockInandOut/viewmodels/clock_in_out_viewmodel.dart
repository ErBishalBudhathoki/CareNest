import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repositories/clock_in_out_repository.dart';

final clockInOutViewModelProvider =
    StateNotifierProvider.autoDispose<ClockInOutViewModel, AsyncValue<bool>>(
        (ref) {
  final repository = ref.watch(clockInOutRepositoryProvider);
  return ClockInOutViewModel(repository);
});

class ClockInOutViewModel extends StateNotifier<AsyncValue<bool>> {
  final ClockInOutRepository _repository;

  ClockInOutViewModel(this._repository)
      : super(const AsyncValue.data(false)); // false = not tracking

  // TODO: Check active status on init

  Future<void> startTimer({
    required String userEmail,
    required String clientEmail,
    required String organizationId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.startTimer(
        userEmail: userEmail,
        clientEmail: clientEmail,
        organizationId: organizationId,
      );
      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> stopTimer({
    required String userEmail,
    required String organizationId,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.stopTimer(
        userEmail: userEmail,
        organizationId: organizationId,
      );
      state = const AsyncValue.data(false);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
