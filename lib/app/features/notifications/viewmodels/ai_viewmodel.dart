
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/notifications/models/ai_models.dart';
import 'package:carenest/app/features/notifications/repositories/ai_repository.dart';

class AiState {
  final List<TimingPrediction> predictions;
  final List<CalendarEvent> calendarEvents;
  final List<SnoozeRule> snoozeRules;
  final bool isLoading;
  final String? errorMessage;
  
  const AiState({
    this.predictions = const [],
    this.calendarEvents = const [],
    this.snoozeRules = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  AiState copyWith({
    List<TimingPrediction>? predictions,
    List<CalendarEvent>? calendarEvents,
    List<SnoozeRule>? snoozeRules,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AiState(
      predictions: predictions ?? this.predictions,
      calendarEvents: calendarEvents ?? this.calendarEvents,
      snoozeRules: snoozeRules ?? this.snoozeRules,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class AiViewModel extends Notifier<AiState> {
  late final AiRepository _repository;

  @override
  AiState build() {
    _repository = ref.watch(aiRepositoryProvider);
    return const AiState();
  }

  // --- Predictions ---

  Future<void> loadPredictions() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final result = await _repository.getPredictions();
      state = state.copyWith(predictions: result);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // --- Calendar ---

  Future<void> loadCalendarEvents({DateTime? start, DateTime? end}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final result = await _repository.getCalendarEvents(start: start, end: end);
      state = state.copyWith(calendarEvents: result);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> syncCalendar(String provider) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.syncCalendar(provider);
      final result = await _repository.getCalendarEvents();
      state = state.copyWith(calendarEvents: result); // Reload after sync
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // --- Snooze ---

  Future<void> loadSnoozeRules() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final result = await _repository.getSnoozeRules();
      state = state.copyWith(snoozeRules: result);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> createSnoozeRule(SnoozeRule rule) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.createSnoozeRule(rule);
      await loadSnoozeRules(); // Reload list
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteSnoozeRule(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteSnoozeRule(id);
      final updated = state.snoozeRules.where((r) => r.id != id).toList();
      state = state.copyWith(snoozeRules: updated);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
