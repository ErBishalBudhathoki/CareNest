import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/notification_model.dart';
import '../models/notification_settings_model.dart';
import '../models/geofence_model.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.read(app_providers.apiMethodProvider));
});

class NotificationRepository {
  final ApiMethod _apiMethod;

  NotificationRepository(this._apiMethod);

  // --- Settings ---

  Future<NotificationSettingsModel> getSettings() async {
    final response = await _apiMethod.get('api/notifications/settings');

    if (response['success'] == true) {
      return NotificationSettingsModel.fromJson(response['data']);
    } else {
      throw Exception(
          response['message'] ?? 'Failed to fetch notification settings');
    }
  }

  Future<NotificationSettingsModel> updateSettings(
      NotificationSettingsModel settings) async {
    final response = await _apiMethod.put(
      'api/notifications/settings',
      body: settings.toJson(),
    );

    if (response['success'] == true) {
      return NotificationSettingsModel.fromJson(response['data']);
    } else {
      throw Exception(
          response['message'] ?? 'Failed to update notification settings');
    }
  }

  // --- History ---

  Future<List<NotificationModel>> getHistory(
      {int page = 1, int limit = 20, String? type}) async {
    String query = '?page=$page&limit=$limit';
    if (type != null) {
      query += '&type=$type';
    }

    final response = await _apiMethod.get('api/notifications/history$query');

    if (response['success'] == true) {
      final List<dynamic> list = response['data']['notifications'];
      return list.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      throw Exception(
          response['message'] ?? 'Failed to fetch notification history');
    }
  }

  Future<void> markAsRead(String id) async {
    final response = await _apiMethod.put('api/notifications/$id/read');

    if (response['success'] != true) {
      throw Exception(
          response['message'] ?? 'Failed to mark notification as read');
    }
  }

  // --- Geofence ---

  Future<List<GeofenceModel>> getGeofences({String? clientId}) async {
    String query = '';
    if (clientId != null) {
      query = '?clientId=$clientId';
    }

    final response = await _apiMethod.get('api/geofence/locations$query');

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => GeofenceModel.fromJson(e)).toList();
    } else {
      throw Exception(
          response['message'] ?? 'Failed to fetch geofence locations');
    }
  }

  Future<GeofenceModel> createGeofence(GeofenceModel geofence) async {
    final response = await _apiMethod.post(
      'api/geofence/locations',
      body: geofence.toJson(),
    );

    if (response['success'] == true) {
      return GeofenceModel.fromJson(response['data']);
    } else {
      throw Exception(
          response['message'] ?? 'Failed to create geofence location');
    }
  }

  Future<GeofenceModel> updateGeofence(GeofenceModel geofence) async {
    final response = await _apiMethod.put(
      'api/geofence/locations/${geofence.id}',
      body: geofence.toJson(),
    );

    if (response['success'] == true) {
      return GeofenceModel.fromJson(response['data']);
    } else {
      throw Exception(
          response['message'] ?? 'Failed to update geofence location');
    }
  }

  Future<void> deleteGeofence(String id) async {
    final response = await _apiMethod.delete('api/geofence/locations/$id');

    if (response['success'] != true) {
      throw Exception(
          response['message'] ?? 'Failed to delete geofence location');
    }
  }
}
