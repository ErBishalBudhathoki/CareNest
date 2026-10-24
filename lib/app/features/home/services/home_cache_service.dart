import 'dart:convert';

import 'package:carenest/app/features/home/models/home_dashboard_data.dart';
import 'package:carenest/app/features/teams/models/team_models.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDashboardSnapshot {
  final HomeDashboardData data;
  final DateTime cachedAt;

  const HomeDashboardSnapshot({required this.data, required this.cachedAt});
}

/// Persists the last successful worker home dashboard so SIL/NDIS shifts are
/// still visible when the device loses connectivity.
///
/// Uses the same SharedPreferences persistence pattern as the earnings cache;
/// it works on every platform (including tests) without a Hive path bootstrap.
class HomeCacheService {
  static const String _keyPrefix = 'home_dashboard_';
  static const Duration _freshFor = Duration(minutes: 5);

  String _key(String userEmail) => '$_keyPrefix$userEmail';

  Future<void> save(String userEmail, HomeDashboardData data) async {
    if (userEmail.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _key(userEmail),
        jsonEncode({
          'cachedAt': DateTime.now().toIso8601String(),
          'broadcasts': data.activeBroadcasts.map((b) => b.toJson()).toList(),
          'appointments': data.upcomingAppointments,
        }),
      );
    } catch (e) {
      debugPrint('HomeCacheService: failed to cache dashboard: $e');
    }
  }

  Future<HomeDashboardSnapshot?> read(String userEmail) async {
    if (userEmail.isEmpty) return null;
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key(userEmail));
      if (raw == null) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final map = Map<String, dynamic>.from(decoded);
      final cachedAt = DateTime.tryParse(map['cachedAt']?.toString() ?? '');
      if (cachedAt == null) return null;

      final broadcasts = ((map['broadcasts'] as List?) ?? const [])
          .whereType<Map>()
          .map((e) => EmergencyBroadcast.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      final appointments = ((map['appointments'] as List?) ?? const [])
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      return HomeDashboardSnapshot(
        data: HomeDashboardData(
          activeBroadcasts: broadcasts,
          upcomingAppointments: appointments,
          lastSyncedAt: cachedAt,
        ),
        cachedAt: cachedAt,
      );
    } catch (e) {
      debugPrint('HomeCacheService: failed to read dashboard cache: $e');
      return null;
    }
  }

  /// True when the snapshot is recent enough to render without a stale badge.
  bool isFresh(DateTime cachedAt) =>
      DateTime.now().difference(cachedAt) <= _freshFor;

  Future<void> clear(String userEmail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key(userEmail));
    } catch (_) {}
  }
}
