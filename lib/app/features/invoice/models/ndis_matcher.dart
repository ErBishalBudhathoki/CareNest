import 'dart:convert';

import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/services.dart';
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
  final ApiMethod _apiMethod;

  NDISMatcher({required ApiMethod apiMethod}) : _apiMethod = apiMethod;

  Map<String, dynamic> _normalizeSupportItem(Map<String, dynamic> itemData) {
    if (itemData.containsKey('Support Item Number')) {
      return Map<String, dynamic>.from(itemData);
    }

    String asString(dynamic value) => value == null ? '' : value.toString();
    bool toBool(dynamic value) {
      if (value is bool) return value;
      final normalized = value?.toString().trim().toLowerCase();
      return normalized == 'true' ||
          normalized == 'yes' ||
          normalized == 'y' ||
          normalized == '1';
    }

    Map<String, dynamic> supportCategory = {};
    if (itemData['supportCategory'] is Map) {
      supportCategory = Map<String, dynamic>.from(
        itemData['supportCategory'] as Map,
      );
    }

    Map<String, dynamic> registrationGroup = {};
    if (itemData['registrationGroup'] is Map) {
      registrationGroup = Map<String, dynamic>.from(
        itemData['registrationGroup'] as Map,
      );
    }

    Map<String, dynamic> priceCaps = {};
    if (itemData['priceCaps'] is Map) {
      priceCaps = Map<String, dynamic>.from(itemData['priceCaps'] as Map);
    }

    Map<String, dynamic> standardPrices = {};
    if (priceCaps['standard'] is Map) {
      standardPrices = Map<String, dynamic>.from(priceCaps['standard'] as Map)
          .map(
            (key, value) =>
                MapEntry(key.toString().trim().toUpperCase(), value),
          );
    }

    Map<String, dynamic> highIntensityPrices = {};
    if (priceCaps['highIntensity'] is Map) {
      highIntensityPrices =
          Map<String, dynamic>.from(priceCaps['highIntensity'] as Map).map(
            (key, value) =>
                MapEntry(key.toString().trim().toUpperCase(), value),
          );
    }

    dynamic resolveRegionalPrice(String stateCode) {
      final code = stateCode.trim().toUpperCase();
      return standardPrices[code] ?? itemData[code] ?? itemData[' $code '];
    }

    return {
      'Support Item Number': asString(
        itemData['supportItemNumber'] ?? itemData['itemNumber'],
      ),
      'Support Item Name': asString(
        itemData['supportItemName'] ?? itemData['itemName'],
      ),
      'Support Category Number': asString(
        itemData['supportCategoryNumber'] ?? supportCategory['number'],
      ),
      'Support Category Name': asString(
        itemData['supportCategoryName'] ?? supportCategory['name'],
      ),
      'Registration Group Number': asString(
        itemData['registrationGroupNumber'] ?? registrationGroup['number'],
      ),
      'Registration Group Name': asString(
        itemData['registrationGroupName'] ?? registrationGroup['name'],
      ),
      'Unit': asString(itemData['unit']),
      'Quote': toBool(itemData['quoteRequired'] ?? itemData['isQuotable'])
          ? 'Yes'
          : 'No',
      'Type': asString(
        itemData['Type'] ??
            itemData['supportType'] ??
            itemData['type'] ??
            itemData['Support Type'] ??
            'Price Limited Supports',
      ),
      'Start date': asString(itemData['startDate']),
      'End Date': asString(itemData['endDate']),
      'Support Category Number (PACE)': asString(
        itemData['supportCategoryNumberPACE'],
      ),
      'Support Category Name (PACE)': asString(
        itemData['supportCategoryNamePACE'],
      ),
      'Non-Face-to-Face Support Provision': asString(
        itemData['nonFaceToFaceSupport'] ??
            itemData['rules']?['allowNonFaceToFace'],
      ),
      'Provider Travel': asString(
        itemData['providerTravel'] ?? itemData['rules']?['allowProviderTravel'],
      ),
      'Short Notice Cancellations.': asString(
        itemData['shortNoticeCancellations'] ??
            itemData['rules']?['allowShortNoticeCancellation'],
      ),
      'NDIA Requested Reports': asString(
        itemData['ndiaRequestedReports'] ??
            itemData['rules']?['ndiaRequiresQuote'],
      ),
      'Irregular SIL Supports': asString(
        itemData['irregularSILSupports'] ??
            itemData['rules']?['isIrregularSupport'],
      ),
      ' ACT ': resolveRegionalPrice('ACT'),
      ' NSW ': resolveRegionalPrice('NSW'),
      ' NT ': resolveRegionalPrice('NT'),
      ' QLD ': resolveRegionalPrice('QLD'),
      ' SA ': resolveRegionalPrice('SA'),
      ' TAS ': resolveRegionalPrice('TAS'),
      ' VIC ': resolveRegionalPrice('VIC'),
      ' WA ': resolveRegionalPrice('WA'),
      ' Remote ': resolveRegionalPrice('REMOTE'),
      ' Very Remote ': resolveRegionalPrice('VERY REMOTE'),
      'P01': itemData['P01'] ?? highIntensityPrices['P01'],
      'P02': itemData['P02'] ?? highIntensityPrices['P02'],
    };
  }

  Future<List<NDISItem>> _loadFromBundledAsset() async {
    try {
      log.warning(
        "NDISMatcher: Falling back to bundled asset assets/ndis_support_items.json.",
      );
      final payload = await rootBundle.loadString(
        'assets/ndis_support_items.json',
      );
      final decoded = jsonDecode(payload);
      if (decoded is! List) {
        log.warning("NDISMatcher: Bundled asset payload is not a list.");
        return [];
      }

      final loadedItems = decoded
          .whereType<Map>()
          .map((raw) => NDISItem.fromJson(Map<String, dynamic>.from(raw)))
          .where((item) => item.itemNumber.isNotEmpty)
          .toList();

      log.info(
        "NDISMatcher: Loaded ${loadedItems.length} NDIS items from bundled asset.",
      );
      return loadedItems;
    } catch (e, s) {
      log.severe("NDISMatcher: Failed loading bundled NDIS asset.", e, s);
      return [];
    }
  }

  Future<void> loadItems({bool forceReload = false}) async {
    if (_isLoaded && !forceReload) return;
    log.info("NDISMatcher: Loading items from database...");
    try {
      final List<Map<String, dynamic>> supportItemsData = await _apiMethod
          .getAllSupportItems();

      if (supportItemsData.isEmpty) {
        log.warning("NDISMatcher: No support items found in database.");
        items = await _loadFromBundledAsset();
        _isLoaded = true;
        return;
      }

      items = supportItemsData
          .map(_normalizeSupportItem)
          .map((itemData) => NDISItem.fromJson(itemData))
          .where((item) => item.itemNumber.isNotEmpty)
          .toList();

      if (items.isEmpty) {
        log.warning(
          "NDISMatcher: Database returned support items but none could be parsed. Falling back to bundled asset.",
        );
        items = await _loadFromBundledAsset();
      }

      _isLoaded = true;
      log.info("NDISMatcher: Successfully loaded ${items.length} NDIS items.");
    } catch (e, s) {
      log.severe("NDISMatcher: Failed to load NDIS items from database.", e, s);
      items = await _loadFromBundledAsset();
      _isLoaded = true;
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
    return knownHolidays.any(
      (d) => d.year == date.year && d.month == date.month && d.day == date.day,
    );
  }

  NDISItem? getItemByNumber(String itemNumber) {
    if (!_isLoaded) {
      log.warning(
        "NDISMatcher: getItemByNumber called before items were loaded.",
      );
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
        "NDISMatcher: findBestMatch called before items were loaded.",
      );
      throw Exception("NDISMatcher: Items not loaded. Call loadItems() first.");
    }
    log.fine(
      "NDISMatcher: Finding best match for shift: $shiftStart, Holidays: $dynamicHolidays, PrefCat: $preferredSupportCategoryNumber, PrefRegGrp: $preferredRegistrationGroupNumber, HI: $isHighIntensityShift, TTP: $preferTTP",
    );

    final shiftDateOnly = DateUtils.dateOnly(shiftStart);
    final String shiftDateString = DateFormat(
      'yyyy-MM-dd',
    ).format(shiftDateOnly);

    final bool isActualHoliday =
        dynamicHolidays.contains(shiftDateString) ||
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
        "NDISMatcher: No items passed initial filtering for shift: $shiftStart.",
      );
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
      bool itemIsHI =
          itemNameLower.contains("high intensity") ||
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
        bool dayMismatch =
            (itemNameLower.contains("saturday") &&
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
        "NDISMatcher: No candidates scored positively for shift: $shiftStart.",
      );
      return null;
    }

    // Sort by score, descending
    scoredCandidates.sort((a, b) => b.value.compareTo(a.value));

    log.fine("NDISMatcher: Top candidates for shift at $shiftStart:");
    scoredCandidates.take(3).forEach((entry) {
      log.fine(
        "  Score: ${entry.value}, Item: ${entry.key.itemNumber} - ${entry.key.itemName}",
      );
    });

    if (scoredCandidates.first.value > 50) {
      log.info(
        "NDISMatcher: Best match found: ${scoredCandidates.first.key.itemNumber} (Score: ${scoredCandidates.first.value})",
      );
      return scoredCandidates.first.key;
    }

    log.warning(
      "NDISMatcher: No confident match found (highest score: ${scoredCandidates.first.value}). Shift: $shiftStart, Holiday: $isActualHoliday, Dynamic Holidays: $dynamicHolidays",
    );

    return null; // No confident match
  }
}
