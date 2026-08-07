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

  TimerState({this.isRunning = false, this.elapsedTime = Duration.zero});

  TimerState copyWith({bool? isRunning, Duration? elapsedTime}) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}

// Notifier wrapper for TimerService
class TimerServiceNotifier extends Notifier<TimerService> {
  @override
  TimerService build() => TimerService();
}

// Timer service provider
final timerServiceProvider =
    NotifierProvider<TimerServiceNotifier, TimerService>(
      TimerServiceNotifier.new,
    );

// ==================== SHIFT DATA ====================

// Notifier for shift data management
class ShiftDataNotifier extends Notifier<List<dynamic>> {
  @override
  List<dynamic> build() => [];

  /// Update all shifts
  void updateShifts(List<dynamic> newShifts) {
    state = newShifts;
  }

  /// Mark a specific shift as completed
  void markShiftCompleted(int index) {
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) {...state[i], 'isCompleted': true} else state[i],
    ];
  }

  /// Clear all shifts
  void clearShifts() {
    state = [];
  }
}

// Shift data provider
final shiftDataProvider = NotifierProvider<ShiftDataNotifier, List<dynamic>>(
  ShiftDataNotifier.new,
);
