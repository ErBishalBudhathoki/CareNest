
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import '../models/ai_models.dart';

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return AiRepository(ApiMethod());
});

class AiRepository {
  final ApiMethod _apiMethod;

  AiRepository(this._apiMethod);

  // --- AI Timing ---

  Future<List<TimingPrediction>> getPredictions() async {
    final response = await _apiMethod.get('api/notifications/ai-timing/predictions');

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => TimingPrediction.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch predictions');
    }
  }

  Future<TimingPrediction> getPrediction(String type) async {
    final response = await _apiMethod.get('api/notifications/ai-timing/predict/$type');

    if (response['success'] == true) {
      return TimingPrediction.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch prediction');
    }
  }

  Future<void> logEngagement(String notificationId, String action) async {
    await _apiMethod.post(
      'api/notifications/ai-timing/engagement',
      body: {'notificationId': notificationId, 'action': action},
    );
  }

  // --- Calendar ---

  Future<List<CalendarEvent>> getCalendarEvents({DateTime? start, DateTime? end}) async {
    String query = '';
    if (start != null) query += '?start=${start.toIso8601String()}';
    if (end != null) query += '&end=${end.toIso8601String()}';

    final response = await _apiMethod.get('api/calendar/events$query');

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => CalendarEvent.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch calendar events');
    }
  }

  Future<void> syncCalendar(String provider) async {
    final response = await _apiMethod.post('api/calendar/sync', body: {'provider': provider});

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to sync calendar');
    }
  }

  // --- Snooze ---

  Future<List<SnoozeRule>> getSnoozeRules() async {
    final response = await _apiMethod.get('api/snooze/rules');

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => SnoozeRule.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch snooze rules');
    }
  }

  Future<SnoozeRule> createSnoozeRule(SnoozeRule rule) async {
    final response = await _apiMethod.post(
      'api/snooze/rules',
      body: rule.toJson(),
    );

    if (response['success'] == true) {
      return SnoozeRule.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to create snooze rule');
    }
  }

  Future<void> deleteSnoozeRule(String id) async {
    final response = await _apiMethod.delete('api/snooze/rules/$id');

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to delete snooze rule');
    }
  }
}
