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

  // Method to fetch holidays from Nager.Date API for the current year

  HolidayService(this._apiMethod);

  Future<List<Holiday>> getAllHolidays() async {
    try {
      final publicHolidays = await _fetchPublicHolidays();
      final customHolidays = await _fetchCustomHolidays();

      final merged = [...publicHolidays, ...customHolidays];
      merged.sort((a, b) => a.date.compareTo(b.date));
      return merged;
    } catch (e) {
      debugPrint('Error fetching holidays: $e');
      // If public API fails, at least return custom holidays or cached
      try {
        return await _fetchCustomHolidays();
      } catch (e2) {
        return [];
      }
    }
  }

  Future<List<Holiday>> _fetchPublicHolidays() async {
    final List<Holiday> holidays = [];
    try {
      final currentYear = DateTime.now().year;
      final url = 'https://date.nager.at/api/v3/publicholidays/$currentYear/AU';

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

            // Map jurisdictions
            // If counties is null, it's National.
            // If not null, it's a list like ["AU-ACT", "AU-NSW"].
            // Our app supports single jurisdiction filtering.
            // We can create multiple Holiday objects for each state if needed,
            // or just label it based on the first one if the UI only filters by simple state keys.
            // But wait, the UI filters: National, NSW, VIC, etc.
            // If a holiday is in multiple states but not all, we should probably add it for each state.

            if (counties == null) {
              // National
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
                // countyCode is "AU-NSW" -> "NSW"
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
    } catch (e) {
      debugPrint('Error in _fetchPublicHolidays: $e');
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
