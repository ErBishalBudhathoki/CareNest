import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

/// Repository for persisting and retrieving the user's date format preference.
///
/// Uses `SharedPreferencesUtils` for local storage. This is the only layer
/// that interacts with SharedPreferences for date format preference.
class DatePreferenceRepository {
  final SharedPreferencesUtils _prefs;

  /// Construct with an injected SharedPreferencesUtils instance.
  DatePreferenceRepository(this._prefs);

  /// Save the date format preference.
  ///
  /// Parameters:
  /// - [preference]: 'mdy' for month/day/year, 'dmy' for day/month/year.
  ///
  /// Throws `ArgumentError` if the preference is not one of the allowed values.
  Future<void> savePreference(String preference) async {
    await _prefs.saveDateFormatPreference(preference);
  }

  /// Retrieve the stored date format preference.
  ///
  /// Returns 'mdy', 'dmy', or null if not set.
  Future<String?> getPreference() async {
    await _prefs.init();
    return _prefs.getDateFormatPreference();
  }
}