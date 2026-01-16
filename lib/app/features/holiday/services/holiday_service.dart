import 'dart:convert';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/features/holiday/models/holiday_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
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

      // Merge lists
      // Note: We might want to deduplicate here if a custom holiday overrides a public one
      // For now, we return both.
      return [...publicHolidays, ...customHolidays];
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
              holidays.add(Holiday(
                id: 'public_${date.millisecondsSinceEpoch}_${name.hashCode}_nat',
                title: name,
                date: date,
                jurisdiction: 'national',
                isPublic: true,
                isCustom: false,
              ));
            } else {
              for (var countyCode in counties) {
                // countyCode is "AU-NSW" -> "NSW"
                final state = countyCode.toString().replaceFirst('AU-', '');
                holidays.add(Holiday(
                  id: 'public_${date.millisecondsSinceEpoch}_${name.hashCode}_$state',
                  title: name,
                  date: date,
                  jurisdiction: state.toLowerCase(),
                  isPublic: true,
                  isCustom: false,
                ));
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
      
      // Pass organizationId to backend if available
      final List<dynamic>? rawHolidays = await _apiMethod.getHolidays(organizationId: currentOrgId);
      final currentYear = DateTime.now().year;

      if (rawHolidays != null) {
        for (var item in rawHolidays) {
          // Organization Filter (Double check on client side)
          final itemOrgId = item['OrganizationId'] ?? item['organizationId'];

          if (currentOrgId != null &&
              itemOrgId != null &&
              itemOrgId != currentOrgId) {
            continue; 
          }

          final dateStr = item['Date'];
          final id =
              item['_id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
          final name = item['Holiday'] ??
              item['HolidayName'] ??
              item['name'] ??
              'Custom Holiday';

          if (dateStr != null) {
            try {
              final date = DateFormat("dd-MM-yyyy").parse(dateStr);
              // Filter by current year to avoid showing old "PAST" holidays
              // NOTE: For pay calculation, we might need older/future ones, but this view is likely just for the "Holidays List"
              // For now, keeping the year filter as it was, but this might be an issue if generating payslips for last year.
              // Let's REMOVE the year filter so invoices work correctly for any period.
              
              customHolidays.add(Holiday(
                id: id,
                title: name,
                date: date,
                jurisdiction: 'custom',
                isPublic: false,
                isCustom: true,
              ));
              
            } catch (e) {
              debugPrint("Error parsing custom holiday date: $dateStr");
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error in _fetchCustomHolidays: $e');
    }
    return customHolidays;
  }
}
