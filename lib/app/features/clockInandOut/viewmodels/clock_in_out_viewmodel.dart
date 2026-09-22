import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/clock_in_out_repository.dart';

final clockInOutViewModelProvider =
    AsyncNotifierProvider.autoDispose<ClockInOutViewModel, bool>(
      ClockInOutViewModel.new,
    );

class ClockInOutViewModel extends AsyncNotifier<bool> {
  // NOTE: never cache providers in `late final` fields here — build() can
  // re-run on the same notifier instance and reassigning a late final
  // throws LateInitializationError.
  ClockInOutRepository get _repository =>
      ref.read(clockInOutRepositoryProvider);

  @override
  FutureOr<bool> build() {
    ref.watch(clockInOutRepositoryProvider);
    return false;
  }

  // TODO: Check active status on init

  Future<void> startTimer({
    required String userEmail,
    required String clientEmail,
    required String organizationId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repository.startTimer(
        userEmail: userEmail,
        clientEmail: clientEmail,
        organizationId: organizationId,
      );
      return true;
    });
  }

  Future<void> stopTimer({
    required String userEmail,
    required String organizationId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repository.stopTimer(
        userEmail: userEmail,
        organizationId: organizationId,
      );
      return false;
    });
  }
}
