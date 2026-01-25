
import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/notifications/models/ai_models.dart';
import 'package:carenest/app/features/notifications/repositories/ai_repository.dart';

class AiViewModel extends ChangeNotifier {
  final AiRepository _repository;

  AiViewModel(this._repository);

  List<TimingPrediction> _predictions = [];
  List<CalendarEvent> _calendarEvents = [];
  List<SnoozeRule> _snoozeRules = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TimingPrediction> get predictions => _predictions;
  List<CalendarEvent> get calendarEvents => _calendarEvents;
  List<SnoozeRule> get snoozeRules => _snoozeRules;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- Predictions ---

  Future<void> loadPredictions() async {
    _setLoading(true);
    try {
      _predictions = await _repository.getPredictions();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // --- Calendar ---

  Future<void> loadCalendarEvents({DateTime? start, DateTime? end}) async {
    _setLoading(true);
    try {
      _calendarEvents = await _repository.getCalendarEvents(start: start, end: end);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> syncCalendar(String provider) async {
    _setLoading(true);
    try {
      await _repository.syncCalendar(provider);
      await loadCalendarEvents(); // Reload after sync
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // --- Snooze ---

  Future<void> loadSnoozeRules() async {
    _setLoading(true);
    try {
      _snoozeRules = await _repository.getSnoozeRules();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createSnoozeRule(SnoozeRule rule) async {
    _setLoading(true);
    try {
      await _repository.createSnoozeRule(rule);
      await loadSnoozeRules(); // Reload list
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteSnoozeRule(String id) async {
    _setLoading(true);
    try {
      await _repository.deleteSnoozeRule(id);
      _snoozeRules.removeWhere((r) => r.id == id);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // --- Helpers ---

  void _setLoading(bool value) {
    _isLoading = value;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    debugPrint('AiViewModel Error: $message');
  }
}
