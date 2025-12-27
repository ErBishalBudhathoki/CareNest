import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart'; // For DateUtils

class MatchResult {
  final NDISItem item;
  final int score;
  MatchResult(this.item, this.score);
}

class NDISMatcher {
  List<NDISItem> items = [];
  bool _isLoaded = false;
  final ApiMethod _apiMethod = ApiMethod();

  Future<void> loadItems({bool forceReload = false}) async {
    if (_isLoaded && !forceReload) return;
    log.info("NDISMatcher: Loading items from database...");
    try {
      // Load NDIS items from database instead of JSON file
      final List<Map<String, dynamic>> supportItemsData =
          await _apiMethod.getAllSupportItems();

      if (supportItemsData.isEmpty) {
        log.warning("NDISMatcher: No support items found in database.");
        items = [];
        _isLoaded = true;
        return;
      }

      // Convert database items to NDISItem objects
      items = supportItemsData.map((itemData) {
        // Map database fields to NDISItem expected format
        final mappedData = {
          'Support Item Number': itemData['supportItemNumber'] ?? '',
          'Support Item Name': itemData['supportItemName'] ?? '',
          'Support Category Number': itemData['supportCategoryNumber'] ?? '',
          'Support Category Name': itemData['supportCategoryName'] ?? '',
          'Registration Group Number':
              itemData['registrationGroupNumber'] ?? '',
          'Registration Group Name': itemData['registrationGroupName'] ?? '',
          'Unit': itemData['unit'] ?? '',
          'Quote Required': itemData['quoteRequired'] ?? false,
          'Support Type': itemData['supportType'] ?? '',
        };
        return NDISItem.fromJson(mappedData);
      }).toList();

      _isLoaded = true;
      log.info(
          "NDISMatcher: Successfully loaded ${items.length} NDIS items from database.");
    } catch (e, s) {
      log.severe("NDISMatcher: Failed to load NDIS items from database.", e, s);
      rethrow; // Or handle more gracefully
    }
  }

  // Placeholder for actual holiday checking logic
  // In a real app, this would query a database or API, or use a comprehensive list.
  bool _isFixedHoliday(DateTime date) {
    // Example fixed holidays
    final knownHolidays = [
      DateTime(date.year, 1, 1), // New Year's Day
      DateTime(date.year, 1, 26), // Australia Day
      // Good Friday and Easter Monday would need more complex date calculations
      DateTime(date.year, 4, 25), // Anzac Day
      DateTime(date.year, 12, 25), // Christmas Day
      DateTime(date.year, 12, 26), // Boxing Day
    ];
    return knownHolidays.any((d) =>
        d.year == date.year && d.month == date.month && d.day == date.day);
  }

  NDISItem? getItemByNumber(String itemNumber) {
    if (!_isLoaded) {
      log.warning(
          "NDISMatcher: getItemByNumber called before items were loaded.");
      return null;
    }
    try {
      return items.firstWhere((item) => item.itemNumber == itemNumber);
    } catch (e) {
      log.warning("NDISMatcher: Item with number $itemNumber not found.");
      return null;
    }
  }

  NDISItem? findBestMatch({
    required DateTime shiftStart,
    // required DateTime shiftEnd, // Duration might be useful for some items (e.g. distinguishing short vs long night shifts)
    required List<String>
        dynamicHolidays, // List of 'yyyy-MM-dd' holiday strings from API
    String? preferredSupportCategoryNumber,
    String? preferredRegistrationGroupNumber,
    bool isHighIntensityShift = false,
    bool preferTTP = false, // Provider policy might dictate this
  }) {
    if (!_isLoaded) {
      log.warning(
          "NDISMatcher: findBestMatch called before items were loaded.");
      throw Exception("NDISMatcher: Items not loaded. Call loadItems() first.");
    }
    log.fine(
        "NDISMatcher: Finding best match for shift: $shiftStart, Holidays: $dynamicHolidays, PrefCat: $preferredSupportCategoryNumber, PrefRegGrp: $preferredRegistrationGroupNumber, HI: $isHighIntensityShift, TTP: $preferTTP");

    final shiftDateOnly = DateUtils.dateOnly(shiftStart);
    final String shiftDateString =
        DateFormat('yyyy-MM-dd').format(shiftDateOnly);

    final bool isActualHoliday = dynamicHolidays.contains(shiftDateString) ||
        _isFixedHoliday(shiftDateOnly);

    final dayOfWeek =
        shiftStart.weekday; // DateTime.monday = 1, ... DateTime.sunday = 7
    final int hour = shiftStart.hour;

    List<NDISItem> filteredItems = items.where((item) {
      // Basic filters: category and registration group
      if (preferredSupportCategoryNumber != null &&
          item.supportCategoryNumber != preferredSupportCategoryNumber) {
        return false;
      }
      if (preferredRegistrationGroupNumber != null &&
          item.registrationGroupNumber != preferredRegistrationGroupNumber) {
        return false;
      }

      // Filter out items that are "Quotable Supports" if we need a priced item,
      // unless the unit implies it (e.g. some quotable items might be for a 'Day' or 'Each')
      // For now, we assume Price Limited Supports are primary targets for auto-matching.
      if (item.type != "Price Limited Supports" &&
          item.type != "Unit Price = 0.1") {
        // For "Quotable Supports", specific logic would be needed if they can be auto-selected.
        // Generally, they require manual quoting.
        return false;
      }
      if (item.type == "Price Limited Supports" &&
          item.getApplicablePrice() == 0.0 &&
          item.getPriceForRegion(PriceRegion.nsw) == 0.0) {
        // A price-limited item with no price information is unusable for auto-billing.
        return false;
      }

      return true; // Passed initial filters
    }).toList();

    if (filteredItems.isEmpty) {
      log.info(
          "NDISMatcher: No items passed initial filtering for shift: $shiftStart.");
      return null;
    }

    // Scoring candidates
    List<MapEntry<NDISItem, int>> scoredCandidates = [];

    for (var item in filteredItems) {
      int score = 0;
      final itemNameLower = item.itemName.toLowerCase();

      // 1. Day Type Matching (Holiday > Sunday > Saturday > Weekday)
      if (isActualHoliday) {
        if (itemNameLower.contains("public holiday")) score += 100;
      } else if (dayOfWeek == DateTime.sunday) {
        if (itemNameLower.contains("sunday")) score += 90;
      } else if (dayOfWeek == DateTime.saturday) {
        if (itemNameLower.contains("saturday")) score += 80;
      } else {
        // Weekday
        score += 70; // Base score for being a weekday item
      }

      // 2. Time of Day Matching (for Weekdays)
      if (!isActualHoliday &&
          dayOfWeek >= DateTime.monday &&
          dayOfWeek <= DateTime.friday) {
        if ((hour >= 20 || hour < 6)) {
          // Night hours
          if (itemNameLower.contains("weekday night")) score += 50;
          if (itemNameLower.contains("night-time sleepover") &&
              item.unit.toUpperCase() == 'E') {
            score += 55; // Slightly higher for specific type
          }
        } else if (hour >= 18 && hour < 22) {
          // Evening hours (adjust upper limit if needed)
          // NDIS specific definitions for evening may vary, common is 8PM onwards.
          // Some item names specify evening starting earlier. Let's check "weekday evening" explicitly.
          if (itemNameLower.contains("weekday evening") &&
              (hour >= 18 && hour < 22)) {
            score += 40; // Example: 01_015_0107_1_1 (Weekday Evening)
          }
        } else if (hour >= 6 && hour < 18) {
          // Daytime hours
          if (itemNameLower.contains("weekday daytime")) score += 30;
        }
        // Generic weekday items (no specific time in name)
        if (!itemNameLower.contains("night") &&
            !itemNameLower.contains("evening") &&
            !itemNameLower.contains("daytime")) {
          score += 10; // Lower score for less specific time
        }
      }

      // 3. Intensity Matching
      bool itemIsHI = itemNameLower.contains("high intensity") ||
          item.registrationGroupNumber == "0104";
      if (isHighIntensityShift) {
        if (itemIsHI) {
          score += 20;
        } else {
          score -= 5; // Penalize if HI shift but item is not HI
        }
      } else {
        // Standard intensity shift
        if (!itemIsHI) {
          score += 20; // Prefer standard items
        } else if (itemNameLower.contains("standard"))
          score += 15; // Explicitly "standard"
        else
          score -= 10; // Penalize HI item for standard shift
      }

      // 4. TTP Preference
      if (preferTTP && item.isTTP) {
        score += 10;
      } else if (!preferTTP && !item.isTTP) {
        score += 5; // Prefer non-TTP if not explicitly preferring TTP
      }

      // 5. Registration Group match (if not used for initial filtering but as preference)
      if (preferredRegistrationGroupNumber != null &&
          item.registrationGroupNumber == preferredRegistrationGroupNumber) {
        score += 25; // Strong preference
      }

      // Add item to scored list if it has a positive score (meaning some relevance)
      if (score > 0) {
        // If an item explicitly states a day (e.g. "Saturday") but the shift is NOT on that day, heavily penalize or exclude
        bool dayMismatch = (itemNameLower.contains("saturday") &&
                dayOfWeek != DateTime.saturday &&
                !isActualHoliday) ||
            (itemNameLower.contains("sunday") &&
                dayOfWeek != DateTime.sunday &&
                !isActualHoliday) ||
            (itemNameLower.contains("public holiday") && !isActualHoliday) ||
            ((itemNameLower.contains("weekday daytime") ||
                    itemNameLower.contains("weekday evening") ||
                    itemNameLower.contains("weekday night")) &&
                (dayOfWeek == DateTime.saturday ||
                    dayOfWeek == DateTime.sunday ||
                    isActualHoliday));

        if (dayMismatch) {
          score -=
              200; // Heavy penalty for mismatching explicit day/holiday names
        }
        scoredCandidates.add(MapEntry(item, score));
      }
    }

    if (scoredCandidates.isEmpty) {
      log.info(
          "NDISMatcher: No candidates scored positively for shift: $shiftStart.");
      return null;
    }

    // Sort by score, descending
    scoredCandidates.sort((a, b) => b.value.compareTo(a.value));

    log.fine("NDISMatcher: Top candidates for shift at $shiftStart:");
    scoredCandidates.take(3).forEach((entry) {
      log.fine(
          "  Score: ${entry.value}, Item: ${entry.key.itemNumber} - ${entry.key.itemName}");
    });

    if (scoredCandidates.first.value > 50) {
      log.info(
          "NDISMatcher: Best match found: ${scoredCandidates.first.key.itemNumber} (Score: ${scoredCandidates.first.value})");
      return scoredCandidates.first.key;
    }

    log.warning(
        "NDISMatcher: No confident match found (highest score: ${scoredCandidates.first.value}). Shift: $shiftStart, Holiday: $isActualHoliday, Dynamic Holidays: $dynamicHolidays");

    return null; // No confident match
  }
}
