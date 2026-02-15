import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import '../models/shift_model.dart';
import '../models/recommendation_model.dart';

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return ScheduleRepository(apiMethod);
});

class ScheduleRepository {
  final ApiMethod _apiMethod;

  ScheduleRepository(this._apiMethod);

  Future<List<ShiftModel>> getShifts({
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? employeeEmail,
    String? clientEmail,
  }) async {
    String endpoint = 'schedule/shifts/$organizationId?';
    if (startDate != null)
      endpoint += 'startDate=${startDate.toIso8601String()}&';
    if (endDate != null) endpoint += 'endDate=${endDate.toIso8601String()}&';
    if (status != null) endpoint += 'status=$status&';
    if (employeeEmail != null) endpoint += 'employeeEmail=$employeeEmail&';
    if (clientEmail != null) endpoint += 'clientEmail=$clientEmail&';

    final response = await _apiMethod.get(endpoint);

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => ShiftModel.fromJson(e)).toList();
    } else {
      throw Exception(response['error'] ?? 'Failed to fetch shifts');
    }
  }

  Future<ShiftModel> createShift(Map<String, dynamic> shiftData) async {
    final response = await _apiMethod.post('schedule/shift', body: shiftData);

    if (response['success'] == true) {
      return ShiftModel.fromJson(response['data']);
    } else {
      throw Exception(response['error'] ?? 'Failed to create shift');
    }
  }

  Future<ShiftModel> updateShift(
      String shiftId, Map<String, dynamic> updates) async {
    final response =
        await _apiMethod.put('schedule/shift/$shiftId', body: updates);

    if (response['success'] == true) {
      return ShiftModel.fromJson(response['data']);
    } else {
      throw Exception(response['error'] ?? 'Failed to update shift');
    }
  }

  Future<void> deleteShift(String shiftId) async {
    final response = await _apiMethod.delete('schedule/shift/$shiftId');

    if (response['success'] != true) {
      throw Exception(response['error'] ?? 'Failed to delete shift');
    }
  }

  Future<RecommendationsResponse> getRecommendations({
    required String organizationId,
    required DateTime startTime,
    required DateTime endTime,
    String? clientEmail,
    List<String>? requiredSkills,
    double? latitude,
    double? longitude,
  }) async {
    String endpoint = 'schedule/recommendations?organizationId=$organizationId&'
        'startTime=${startTime.toIso8601String()}&'
        'endTime=${endTime.toIso8601String()}&';

    if (clientEmail != null) endpoint += 'clientEmail=$clientEmail&';
    if (requiredSkills != null && requiredSkills.isNotEmpty) {
      endpoint += 'requiredSkills=${requiredSkills.join(',')}&';
    }
    if (latitude != null) endpoint += 'latitude=$latitude&';
    if (longitude != null) endpoint += 'longitude=$longitude&';

    final response = await _apiMethod.get(endpoint);

    if (response['success'] == true) {
      // Backend returns structure matching RecommendationsResponse directly or nested?
      // Controller returns `result`. Service returns `result` with `recommendations` array.
      // So response body is the JSON.
      return RecommendationsResponse.fromJson(response);
    } else {
      throw Exception(response['error'] ?? 'Failed to get recommendations');
    }
  }
}
