import 'dart:convert';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/invoice/models/period_config.dart';

/// Repository for persisting and retrieving period configurations
/// per employee-client combination.
///
/// Uses SharedPreferences for local persistence.
class PeriodConfigRepository {
  final SharedPreferencesUtils _prefs;

  /// Create a repository with a SharedPreferencesUtils dependency.
  PeriodConfigRepository(this._prefs);

  static const String _kPrefix = 'period_config';

  /// Build a storage key for an employee-client pair.
  String _key(String employeeEmail, String clientEmail) {
    final e = employeeEmail.trim().toLowerCase();
    final c = clientEmail.trim().toLowerCase();
    return '$_kPrefix:$e:$c';
  }

  /// Save a period configuration.
  ///
  /// Throws if emails are empty.
  Future<void> saveConfig(PeriodConfig config) async {
    if (config.employeeEmail.isEmpty || config.clientEmail.isEmpty) {
      throw Exception('PeriodConfigRepository: employeeEmail/clientEmail required');
    }
    await _prefs.init();
    final key = _key(config.employeeEmail, config.clientEmail);
    final jsonStr = jsonEncode(config.toJson());
    await _prefs.setString(key, jsonStr);
  }

  /// Retrieve a period configuration for an employee-client pair.
  Future<PeriodConfig?> getConfig(String employeeEmail, String clientEmail) async {
    await _prefs.init();
    final key = _key(employeeEmail, clientEmail);
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return PeriodConfig.fromJson(map);
    } catch (e) {
      // If decode fails, remove corrupted entry and return null
      await _prefs.remove(key);
      return null;
    }
  }

  /// Remove a stored configuration.
  Future<void> removeConfig(String employeeEmail, String clientEmail) async {
    await _prefs.init();
    final key = _key(employeeEmail, clientEmail);
    await _prefs.remove(key);
  }
}