import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:flutter/foundation.dart';

final timesheetRepositoryProvider =
    Provider((ref) => TimesheetRepository(ApiMethod()));

class TimesheetRepository {
  final ApiMethod _apiMethod;

  TimesheetRepository(this._apiMethod);

  Future<List<TimesheetEntry>> fetchTimesheets({
    required String email,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _apiMethod.post(
        'getWorkedTime',
        body: {
          'email': email,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        },
      );

      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => TimesheetEntry.fromJson(json)).toList();
      } else {
        debugPrint('Failed to fetch timesheets: ${response['message']}');
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching timesheets: $e');
      throw Exception('Failed to load timesheets');
    }
  }
}
