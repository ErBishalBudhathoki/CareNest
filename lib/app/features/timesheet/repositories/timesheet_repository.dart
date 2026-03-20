import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

final timesheetRepositoryProvider = Provider(
    (ref) => TimesheetRepository(ref.read(app_providers.apiMethodProvider)));

class TimesheetRepository {
  final ApiMethod _apiMethod;

  TimesheetRepository(this._apiMethod);

  Future<List<TimesheetEntry>> fetchTimesheets({
    required String email,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      final organizationId = sharedPrefs.getString('organizationId');
      if (organizationId == null || organizationId.trim().isEmpty) {
        throw Exception('Organization context missing for timesheet request');
      }

      final response = await _apiMethod.post(
        'timesheets/list',
        body: {
          'email': email,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'organizationId': organizationId,
        },
      );

      if (response['success'] == true && response['data'] != null) {
        final rawData = response['data'];
        if (rawData is! List) {
          return [];
        }
        final List<dynamic> data = rawData;
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
