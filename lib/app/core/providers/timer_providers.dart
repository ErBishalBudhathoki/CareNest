// Timer and Shift Providers - Time tracking and shift management
//
// Contains providers for timer service and shift data management.

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/services/timer_service.dart';

// ==================== TIMER STATE ====================

// State for timer functionality
class TimerState {
  final Duration elapsedTime;
  Timer? timer;
  int elapsedSeconds = 0;
  bool isRunning = false;
  DateTime startTime = DateTime.now();

  TimerState({
    this.isRunning = false,
    this.elapsedTime = Duration.zero,
  });

  TimerState copyWith({
    bool? isRunning,
    Duration? elapsedTime,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}

// Notifier wrapper for TimerService
class TimerServiceNotifier extends StateNotifier<TimerService> {
  TimerServiceNotifier() : super(TimerService());
}

// Timer service provider (StateNotifier version)
final timerServiceProvider = StateNotifierProvider<TimerServiceNotifier, TimerService>((ref) {
  return TimerServiceNotifier();
});

// Timer service provider (ChangeNotifier version for legacy compatibility)
final timerServiceProviderWithNotifier = ChangeNotifierProvider<TimerService>((ref) {
  return TimerService();
});

// ==================== SHIFT DATA ====================

// Notifier for shift data management
class ShiftDataNotifier extends StateNotifier<List<dynamic>> {
  ShiftDataNotifier() : super([]);

  /// Update all shifts
  void updateShifts(List<dynamic> newShifts) {
    state = newShifts;
  }

  /// Mark a specific shift as completed
  void markShiftCompleted(int index) {
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) {...state[i], 'isCompleted': true} else state[i]
    ];
  }

  /// Clear all shifts
  void clearShifts() {
    state = [];
  }
}

// Shift data provider
final shiftDataProvider = StateNotifierProvider<ShiftDataNotifier, List<dynamic>>((ref) {
  return ShiftDataNotifier();
});
