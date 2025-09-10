import 'package:intl/intl.dart';
import 'package:flutter/material.dart'; // For DateUtils

// Enum for regional pricing strategy
enum PriceRegion {
  act,
  nsw,
  nt,
  qld,
  sa,
  tas,
  vic,
  wa,
  remote,
  veryRemote,
  national
}

class NDISItem {
  final String itemNumber;
  final String itemName;
  final String supportCategoryNumber;
  final String supportCategoryName;
  final String registrationGroupNumber;
  final String registrationGroupName;
  final String unit;
  final String
      type; // "Price Limited Supports", "Quotable Supports", "Unit Price = $1"
  final bool isQuotable;
  final DateTime? startDate;
  final DateTime? endDate;

  // Store all regional prices
  final Map<PriceRegion, double?> regionalPrices;

  final String supportPurposeId;
  final String generalCategory;

  // New fields from JSON
  final String? supportCategoryNumberPACE;
  final String? supportCategoryNamePACE;
  final String? nonFaceToFaceSupport;
  final String? providerTravel;
  final String? shortNoticeCancellations;
  final String? ndiaRequestedReports;
  final String? irregularSILSupports;

  Map<String, dynamic> toJson() {
    return {
      'itemNumber': itemNumber,
      'itemName': itemName,
      'supportCategoryNumber': supportCategoryNumber,
      'supportCategoryName': supportCategoryName,
      'registrationGroupNumber': registrationGroupNumber,
      'registrationGroupName': registrationGroupName,
      'unit': unit,
      'type': type,
      'isQuotable': isQuotable,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'supportPurposeId': supportPurposeId,
      'generalCategory': generalCategory,
      'supportCategoryNumberPACE': supportCategoryNumberPACE,
      'supportCategoryNamePACE': supportCategoryNamePACE,
      'nonFaceToFaceSupport': nonFaceToFaceSupport,
      'providerTravel': providerTravel,
      'shortNoticeCancellations': shortNoticeCancellations,
      'ndiaRequestedReports': ndiaRequestedReports,
      'irregularSILSupports': irregularSILSupports,
    };
  }

  NDISItem({
    required this.itemNumber,
    required this.itemName,
    required this.supportCategoryNumber,
    required this.supportCategoryName,
    required this.registrationGroupNumber,
    required this.registrationGroupName,
    required this.unit,
    required this.type,
    required this.isQuotable,
    this.startDate,
    this.endDate,
    required this.regionalPrices,
    required this.supportPurposeId,
    required this.generalCategory,
    this.supportCategoryNumberPACE,
    this.supportCategoryNamePACE,
    this.nonFaceToFaceSupport,
    this.providerTravel,
    this.shortNoticeCancellations,
    this.ndiaRequestedReports,
    this.irregularSILSupports,
  });

  factory NDISItem.fromJson(Map<String, dynamic> json,
      {PriceRegion defaultRegion =
          PriceRegion.nsw /* Or your most common region */}) {
    double? parsePrice(dynamic priceValue) {
      if (priceValue == null) return null;
      String priceStr = priceValue.toString().trim(); // Trim spaces
      if (priceStr.isEmpty || priceStr.toLowerCase() == 'nan') return null;
      return double.tryParse(priceStr
          .replaceAll(r'$', '')
          .replaceAll(',', '')
          .trim()); // Handle commas too
    }

    DateTime? parseNDISDate(dynamic dateValue) {
      if (dateValue == null) return null;
      String dateStr = dateValue.toString();
      if (dateStr.length == 8 && int.tryParse(dateStr) != null) {
        // YYYYMMDD
        try {
          return DateTime.parse(
              "${dateStr.substring(0, 4)}-${dateStr.substring(4, 6)}-${dateStr.substring(6, 8)}");
        } catch (e) {
          // log.warning("Could not parse NDIS date '$dateStr': $e");
          return null;
        }
      }
      return null;
    }

    Map<PriceRegion, double?> extractRegionalPrices(
        Map<String, dynamic> jsonMap) {
      final Map<PriceRegion, double?> prices = {};
      prices[PriceRegion.act] =
          parsePrice(jsonMap[" ACT "]); // Note the spaces in keys
      prices[PriceRegion.nsw] = parsePrice(jsonMap[" NSW "]);
      prices[PriceRegion.nt] = parsePrice(jsonMap[" NT "]);
      prices[PriceRegion.qld] = parsePrice(jsonMap[" QLD "]);
      prices[PriceRegion.sa] = parsePrice(jsonMap[" SA "]);
      prices[PriceRegion.tas] = parsePrice(jsonMap[" TAS "]);
      prices[PriceRegion.vic] = parsePrice(jsonMap[" VIC "]);
      prices[PriceRegion.wa] = parsePrice(jsonMap[" WA "]);
      prices[PriceRegion.remote] = parsePrice(jsonMap[" Remote "]);
      prices[PriceRegion.veryRemote] = parsePrice(jsonMap[" Very Remote "]);

      // Fallback for P01/P02 if regional are missing (seen in "Sheet3" of your new example)
      if (prices.values.every((p) => p == null)) {
        final p01 = parsePrice(jsonMap["P01"]); // No spaces for P01/P02 usually
        final p02 = parsePrice(jsonMap["P02"]);
        if (p01 != null || p02 != null) {
          prices[PriceRegion.national] =
              p01 ?? p02; // Use P01 or P02 as a national/default
        }
      }
      return prices;
    }

    String itemNum = json['Support Item Number'] ?? '';
    String supportCatNum = json['Support Category Number']?.toString() ?? '';

    String extractedPurposeId = "0"; // Default
    if (itemNum.isNotEmpty) {
      List<String> numParts = itemNum.replaceAll(RegExp(r'_T$'), '').split('_');
      if (numParts.isNotEmpty) {
        String lastPart = numParts.last;
        // Check if the last part is a digit and a valid purpose ID (1, 2, or 3)
        // and ensure it's not misinterpreting a segment if the item number is short.
        if (["1", "2", "3"].contains(lastPart) && numParts.length > 3) {
          // Check if the segment before the last is likely a reg group or sequence number (alphanumeric or numeric, 3-4 chars)
          String secondLastPart = numParts[numParts.length - 2];
          if (RegExp(r'^[a-zA-Z0-9]{3,4}$').hasMatch(secondLastPart)) {
            extractedPurposeId = lastPart;
          }
        }
      }
    }

    String genCat = "Unknown";
    switch (supportCatNum) {
      case "1":
      case "2":
      case "3":
      case "4":
        genCat = "Core Supports";
        if (extractedPurposeId == "0") extractedPurposeId = "1";
        break;
      case "16": // Home and Living (PACE) - Core
        genCat = "Core Supports";
        if (extractedPurposeId == "0") extractedPurposeId = "1";
        break;
      case "21": // YPIRAC - Core
        genCat = "Core Supports";
        if (extractedPurposeId == "0") extractedPurposeId = "1";
        break;
      case "5":
      case "6":
        genCat = "Capital Supports";
        if (extractedPurposeId == "0") extractedPurposeId = "2";
        break;
      case "17": // SDA (PACE) - Capital
        genCat = "Capital Supports";
        if (extractedPurposeId == "0") extractedPurposeId = "2";
        break;
      case "19": // AT Maintenance, Repair & Rental (PACE) - Capital
        genCat = "Capital Supports";
        if (extractedPurposeId == "0") extractedPurposeId = "2";
        break;
      case "7":
      case "8":
      case "9":
      case "10":
      case "11":
      case "12":
      case "13":
      case "14":
      case "15":
        genCat = "Capacity-Building Supports";
        if (extractedPurposeId == "0") extractedPurposeId = "3";
        break;
      case "20": // Behaviour Support (PACE) - Capacity Building
        genCat = "Capacity-Building Supports";
        if (extractedPurposeId == "0") extractedPurposeId = "3";
        break;
      case "18": // Recurring Transport (PACE)
        genCat = "Recurring Support";
        // No standard 1,2,3 purpose for this. Keep as "0" or use a specific identifier if needed.
        break;
    }

    return NDISItem(
      itemNumber: itemNum,
      itemName: json['Support Item Name'] ?? '',
      supportCategoryNumber: supportCatNum,
      supportCategoryName: json['Support Category Name'] ?? '',
      registrationGroupNumber:
          json['Registration Group Number']?.toString() ?? '',
      registrationGroupName: json['Registration Group Name'] ?? '',
      unit: json['Unit'] ?? '',
      type: json['Type'] ?? 'Unknown',
      isQuotable: (json['Quote']?.toString().toLowerCase() == 'yes'),
      startDate: parseNDISDate(json['Start date']),
      endDate: parseNDISDate(json['End Date']),
      regionalPrices: extractRegionalPrices(json),
      supportPurposeId: extractedPurposeId,
      generalCategory: genCat,
      supportCategoryNumberPACE:
          json['Support Category Number (PACE)']?.toString(),
      supportCategoryNamePACE: json['Support Category Name (PACE)']?.toString(),
      nonFaceToFaceSupport:
          json['Non-Face-to-Face Support Provision']?.toString(),
      providerTravel: json['Provider Travel']?.toString(),
      shortNoticeCancellations:
          json['Short Notice Cancellations.']?.toString(), // Note the dot
      ndiaRequestedReports: json['NDIA Requested Reports']?.toString(),
      irregularSILSupports: json['Irregular SIL Supports']?.toString(),
    );
  }

  // Get price based on a specific region or fallback.
  double getPriceForRegion(PriceRegion region,
      {PriceRegion fallbackRegion = PriceRegion.nsw}) {
    if (type == "Quotable Supports" || isQuotable) return 0.0;
    if (type == "Unit Price = \$1") return 1.0;

    return regionalPrices[region] ??
        regionalPrices[fallbackRegion] ??
        regionalPrices[PriceRegion.national] ??
        0.0;
  }

  // Default applicable price (e.g., for NSW or a national fallback)
  double getApplicablePrice({PriceRegion region = PriceRegion.nsw}) {
    return getPriceForRegion(region);
  }

  bool get isTTP => itemNumber.endsWith("_T");

  bool isActiveAsOf(DateTime date) {
    if (startDate == null) return true; // Assume active if no start date
    if (endDate == null || endDate == DateTime(9999, 12, 31))
      return date.isAfter(startDate!) || date.isAtSameMomentAs(startDate!);
    return (date.isAfter(startDate!) || date.isAtSameMomentAs(startDate!)) &&
        date.isBefore(endDate!
            .add(const Duration(days: 1) /* make end date inclusive */));
  }
}
