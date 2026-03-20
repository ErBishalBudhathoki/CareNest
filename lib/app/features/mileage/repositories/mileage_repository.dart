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

  bool _isRouteNotFound(Map<String, dynamic>? response) {
    if (response == null) return false;
    final statusCode = response['statusCode'];
    if (statusCode is int && statusCode == 404) return true;
    final message = response['message']?.toString().toLowerCase() ?? '';
    return message.contains('route not found');
  }

  bool _isServerError(Map<String, dynamic>? response) {
    if (response == null) return false;
    final statusCode = response['statusCode'];
    return statusCode is int && statusCode >= 500;
  }

  List<Trip> _parseTrips(Map<String, dynamic>? response) {
    if (response == null || response['success'] != true) {
      return [];
    }
    final dynamic data = response['data'] ?? response['trips'];
    if (data is! List) return [];
    return data
        .whereType<Map>()
        .map((json) => Trip.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

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

      final primaryResponse =
          await _apiMethod.get('trips/employee/$userId$query');
      final primaryTrips = _parseTrips(primaryResponse);
      if (primaryTrips.isNotEmpty ||
          (primaryResponse['success'] == true && primaryTrips.isEmpty)) {
        return primaryTrips;
      }

      // Fallback when employee-specific route is unavailable or unstable on deployment.
      if (_isServerError(primaryResponse) ||
          _isRouteNotFound(primaryResponse)) {
        final params = <String>[
          'userId=$userId',
          if (startDate != null) 'startDate=$startDate',
          if (endDate != null) 'endDate=$endDate',
        ].join('&');

        final fallbackResponse = await _apiMethod.get('trips?$params');
        final fallbackTrips = _parseTrips(fallbackResponse);
        return fallbackTrips.where((trip) => trip.userId == userId).toList();
      }

      return [];
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
      // Current backend route shape.
      final primaryResponse = await _apiMethod.get(
          'trips?clientId=$clientId&startDate=$startDate&endDate=$endDate');
      final primaryTrips = _parseTrips(primaryResponse);
      final filteredPrimaryTrips = primaryTrips
          .where((trip) => trip.clientId == clientId)
          .toList();
      if (primaryTrips.isNotEmpty ||
          (primaryResponse['success'] == true && primaryTrips.isEmpty)) {
        return filteredPrimaryTrips;
      }

      // Compatibility fallback for deployments still exposing the old path.
      if (_isRouteNotFound(primaryResponse)) {
        final fallbackResponse = await _apiMethod.get(
            'trips/client/$clientId?startDate=$startDate&endDate=$endDate');
        final fallbackTrips = _parseTrips(fallbackResponse);
        return fallbackTrips.where((trip) => trip.clientId == clientId).toList();
      }
      return [];
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

  Future<List<Map<String, String>>> getAssignableClients(
      String userEmail) async {
    try {
      final response = await _apiMethod.getUserAssignments(userEmail);
      if (response['success'] != true || response['assignments'] is! List) {
        return [];
      }

      final assignments = response['assignments'] as List<dynamic>;
      final seen = <String>{};
      final clients = <Map<String, String>>[];

      for (final assignment in assignments) {
        if (assignment is! Map<String, dynamic>) continue;
        final id = assignment['clientId']?.toString() ?? '';
        if (id.isEmpty || seen.contains(id)) continue;
        seen.add(id);

        final name =
            assignment['clientName']?.toString().trim().isNotEmpty == true
                ? assignment['clientName'].toString()
                : (assignment['clientEmail']?.toString() ?? id);

        clients.add({'id': id, 'name': name});
      }

      return clients;
    } catch (e) {
      print('Error fetching assignable clients: $e');
      return [];
    }
  }
}
