import 'dart:convert';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/holiday/models/holiday_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

final holidayServiceProvider = Provider<HolidayService>((ref) {
  return HolidayService(ref.read(app_providers.apiMethodProvider));
});

class HolidayService {
  final ApiMethod _apiMethod;

  // Nager.Date responses are stable for a calendar year; cache them so an
  // invoice that spans several years does not refetch the same data.
  static final Map<int, List<Holiday>> _publicHolidayCache = {};

  static const Map<String, String> _stateNameToCode = {
    'new south wales': 'NSW',
    'victoria': 'VIC',
    'queensland': 'QLD',
    'south australia': 'SA',
    'western australia': 'WA',
    'tasmania': 'TAS',
    'northern territory': 'NT',
    'australian capital territory': 'ACT',
  };

  HolidayService(this._apiMethod);

  /// Return the merged holiday calendar used for penalty rates.
  ///
  /// Sources:
  ///   1. Nager.Date (officially gazetted national + state holidays)
  ///   2. MongoDB holidays configured by the organisation
  ///
  /// Only public holidays that apply to [jurisdiction] are returned. Custom
  /// organisation holidays are always returned. If the external API fails the
  /// custom holidays are still returned, so a network outage can never make an
  /// organisation holiday disappear.
  Future<List<Holiday>> getAllHolidays({
    DateTime? startDate,
    DateTime? endDate,
    String? jurisdiction,
  }) async {
    final stateCode = normalizeStateCode(jurisdiction);

    List<Holiday> publicHolidays = [];
    try {
      final years = _yearsBetween(startDate, endDate);
      final yearLists = await Future.wait(years.map(_fetchPublicHolidays));
      publicHolidays = [
        for (final list in yearLists)
          for (final holiday in list)
            if (_appliesToState(holiday, stateCode)) holiday,
      ];
    } catch (e) {
      debugPrint('Error fetching public holidays: $e');
    }

    List<Holiday> customHolidays = [];
    try {
      customHolidays = await _fetchCustomHolidays();
    } catch (e) {
      debugPrint('Error fetching organisation holidays: $e');
    }

    // Deduplicate by date. Organisation-defined holidays win so an org can
    // label a day it observes; a date is either a holiday or it is not.
    final byDate = <String, Holiday>{};
    for (final holiday in publicHolidays) {
      byDate[_dateKey(holiday.date)] = holiday;
    }
    for (final holiday in customHolidays) {
      byDate[_dateKey(holiday.date)] = holiday;
    }

    final merged = byDate.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return merged;
  }

  /// Normalise a state name/code to the two- or three-letter code used by the
  /// Nager.Date `counties` field (e.g. `New South Wales` -> `NSW`).
  static String? normalizeStateCode(String? raw) {
    if (raw == null) return null;
    var value = raw.trim();
    if (value.isEmpty) return null;
    if (value.toUpperCase().startsWith('AU-')) {
      value = value.substring(3);
    }
    final upper = value.toUpperCase();
    if (upper.length <= 3) return upper;
    return _stateNameToCode[value.toLowerCase()];
  }

  static bool _appliesToState(Holiday holiday, String? stateCode) {
    final jurisdiction = holiday.jurisdiction.toLowerCase();
    if (jurisdiction == 'national' || jurisdiction == 'custom') return true;
    if (stateCode == null) {
      // Unknown organisation state: only national holidays are safe to apply.
      return false;
    }
    return jurisdiction == stateCode.toLowerCase();
  }

  static String _dateKey(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  static List<int> _yearsBetween(DateTime? startDate, DateTime? endDate) {
    final now = DateTime.now();
    final start = startDate ?? DateTime(now.year);
    final end = endDate ?? start;
    final first = start.isAfter(end) ? end : start;
    final last = start.isAfter(end) ? start : end;
    final years = <int>[];
    for (var year = first.year; year <= last.year && years.length < 6; year++) {
      years.add(year);
    }
    if (years.isEmpty) years.add(now.year);
    return years;
  }

  Future<List<Holiday>> _fetchPublicHolidays(int year) async {
    final cached = _publicHolidayCache[year];
    if (cached != null) return cached;

    final List<Holiday> holidays = [];
    try {
      final url = 'https://date.nager.at/api/v3/publicholidays/$year/AU';

      debugPrint('Fetching public holidays from: $url');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> records = json.decode(response.body);

        for (var record in records) {
          final dateStr = record['date'];
          final name = record['name'] ?? record['localName'];
          final List<dynamic>? counties = record['counties'];

          if (dateStr != null && name != null) {
            final date = DateTime.parse(dateStr);

            // Map jurisdictions.
            // If counties is null, it's National.
            // If not null, it's a list like ["AU-ACT", "AU-NSW"].
            if (counties == null) {
              holidays.add(
                Holiday(
                  id: 'public_${date.millisecondsSinceEpoch}_${name.hashCode}_nat',
                  title: name,
                  date: date,
                  jurisdiction: 'national',
                  isPublic: true,
                  isCustom: false,
                ),
              );
            } else {
              for (var countyCode in counties) {
                final state = countyCode.toString().replaceFirst('AU-', '');
                holidays.add(
                  Holiday(
                    id: 'public_${date.millisecondsSinceEpoch}_${name.hashCode}_$state',
                    title: name,
                    date: date,
                    jurisdiction: state.toLowerCase(),
                    isPublic: true,
                    isCustom: false,
                  ),
                );
              }
            }
          }
        }
      }
      _publicHolidayCache[year] = holidays;
    } catch (e) {
      debugPrint('Error in _fetchPublicHolidays($year): $e');
    }
    return holidays;
  }

  Future<List<Holiday>> _fetchCustomHolidays() async {
    final List<Holiday> customHolidays = [];
    try {
      // Get current user's organization ID
      final prefs = SharedPreferencesUtils();
      await prefs.init();
      final String? currentOrgId = prefs.getOrganizationId();

      // Pass organizationId to backend if available.
      final response = await _apiMethod.getHolidays(
        organizationId: currentOrgId,
      );
      final rawHolidays = response['data'];

      if (rawHolidays is! List) {
        return customHolidays;
      }

      for (final item in rawHolidays) {
        if (item is! Map) continue;
        final map = Map<String, dynamic>.from(item);

        final itemOrgId = map['organizationId'] ?? map['OrganizationId'];
        final itemOrgIdStr = itemOrgId?.toString();
        final bool isCustom =
            map['isCustom'] == true ||
            (itemOrgIdStr != null && itemOrgIdStr.isNotEmpty);

        // We only return organization-specific custom holidays from MongoDB.
        if (!isCustom) continue;
        if (currentOrgId != null &&
            itemOrgIdStr != null &&
            itemOrgIdStr != currentOrgId) {
          continue;
        }

        final name =
            (map['name'] ??
                    map['Holiday'] ??
                    map['HolidayName'] ??
                    map['title'])
                ?.toString() ??
            'Custom Holiday';

        final date = _parseBackendHolidayDate(map['date'] ?? map['Date']);
        if (date == null) {
          debugPrint('Error parsing custom holiday date: ${map['date']}');
          continue;
        }

        customHolidays.add(
          Holiday(
            id: (map['_id'] ?? map['id'] ?? date.millisecondsSinceEpoch)
                .toString(),
            title: name,
            date: date,
            jurisdiction: 'custom',
            isPublic: false,
            isCustom: true,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error in _fetchCustomHolidays: $e');
    }
    return customHolidays;
  }

  DateTime? _parseBackendHolidayDate(dynamic rawDate) {
    if (rawDate == null) return null;
    final value = rawDate.toString().trim();
    if (value.isEmpty) return null;

    try {
      return DateTime.parse(value);
    } catch (_) {}

    // Canonical app format (DD/MM/YYYY).
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(value);
    } catch (_) {}

    // Legacy stored format (DD-MM-YYYY).
    try {
      return DateFormat('dd-MM-yyyy').parseStrict(value);
    } catch (_) {}

    try {
      return DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (_) {
      return null;
    }
  }
}
