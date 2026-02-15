import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/trip_model.dart';

final mileageRepositoryProvider = Provider<MileageRepository>((ref) {
  return MileageRepository(ref.read(app_providers.apiMethodProvider));
});

class MileageRepository {
  final ApiMethod _apiMethod;

  MileageRepository(this._apiMethod);

  /// Fetches trips for a user within a date range.
  /// [userId] The ID of the employee.
  /// [startDate] Start date string (YYYY-MM-DD).
  /// [endDate] End date string (YYYY-MM-DD).
  Future<List<Trip>> getTrips(String userId,
      {String? startDate, String? endDate}) async {
    try {
      String query = '';
      if (startDate != null && endDate != null) {
        query = '?startDate=$startDate&endDate=$endDate';
      }

      final response = await _apiMethod.get('api/trips/employee/$userId$query');

      if (response != null && response['success'] == true) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Trip.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      // Log error appropriately in a real app
      print('Error fetching trips: $e');
      return [];
    }
  }

  /// Fetches billable trips for a client within a date range.
  Future<List<Trip>> getTripsForClient(String clientId,
      {required String startDate, required String endDate}) async {
    try {
      final response = await _apiMethod.get(
          'api/trips/client/$clientId?startDate=$startDate&endDate=$endDate');

      if (response != null && response['success'] == true) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Trip.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching client trips: $e');
      return [];
    }
  }

  /// Saves a new trip.
  Future<bool> saveTrip(Map<String, dynamic> tripData) async {
    try {
      final response = await _apiMethod.post('api/trips', body: tripData);
      return response != null &&
          (response['success'] == true || response['status'] == 201);
    } catch (e) {
      print('Error saving trip: $e');
      return false;
    }
  }
}
