// Shift Model
// Represents a scheduled work shift for NDIS service delivery
//
// @file lib/app/features/schedule/models/shift_model.dart

import 'package:flutter/foundation.dart';

/// Model representing a scheduled shift
@immutable
class ShiftModel {
  final String id;
  final String? employeeId;
  final String? employeeEmail;
  final String? employeeName;
  final String? clientId;
  final String? clientEmail;
  final String? clientName;
  final String organizationId;
  final DateTime startTime;
  final DateTime endTime;
  final List<SupportItemModel> supportItems;
  final ShiftLocation? location;
  final ShiftStatus status;
  final bool isRecurring;
  final String? recurringTemplateId;
  final String? notes;
  final int breakDuration; // in minutes
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ShiftModel({
    required this.id,
    this.employeeId,
    this.employeeEmail,
    this.employeeName,
    this.clientId,
    this.clientEmail,
    this.clientName,
    required this.organizationId,
    required this.startTime,
    required this.endTime,
    this.supportItems = const [],
    this.location,
    this.status = ShiftStatus.pending,
    this.isRecurring = false,
    this.recurringTemplateId,
    this.notes,
    this.breakDuration = 0,
    this.createdAt,
    this.updatedAt,
  });

  /// Create from JSON response
  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      employeeId: json['employeeId']?.toString(),
      employeeEmail: json['employeeEmail']?.toString(),
      employeeName: json['employeeName']?.toString(),
      clientId: json['clientId']?.toString(),
      clientEmail: json['clientEmail']?.toString(),
      clientName: json['clientName']?.toString(),
      organizationId: json['organizationId']?.toString() ?? '',
      startTime: _parseDateTime(json['startTime']) ?? DateTime.now(),
      endTime: _parseDateTime(json['endTime']) ?? DateTime.now(),
      supportItems: (json['supportItems'] as List<dynamic>?)
              ?.map((e) => SupportItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      location: json['location'] != null
          ? ShiftLocation.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      status: ShiftStatus.fromString(json['status']?.toString() ?? 'pending'),
      isRecurring: json['isRecurring'] == true,
      recurringTemplateId: json['recurringTemplateId']?.toString(),
      notes: json['notes']?.toString(),
      breakDuration: (json['breakDuration'] as num?)?.toInt() ?? 0,
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  /// Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      if (employeeId != null) 'employeeId': employeeId,
      if (employeeEmail != null) 'employeeEmail': employeeEmail,
      if (clientId != null) 'clientId': clientId,
      if (clientEmail != null) 'clientEmail': clientEmail,
      'organizationId': organizationId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'supportItems': supportItems.map((e) => e.toJson()).toList(),
      if (location != null) 'location': location!.toJson(),
      'status': status.value,
      'isRecurring': isRecurring,
      if (recurringTemplateId != null) 'recurringTemplateId': recurringTemplateId,
      if (notes != null) 'notes': notes,
      'breakDuration': breakDuration,
    };
  }

  /// Copy with modifications
  ShiftModel copyWith({
    String? id,
    String? employeeId,
    String? employeeEmail,
    String? employeeName,
    String? clientId,
    String? clientEmail,
    String? clientName,
    String? organizationId,
    DateTime? startTime,
    DateTime? endTime,
    List<SupportItemModel>? supportItems,
    ShiftLocation? location,
    ShiftStatus? status,
    bool? isRecurring,
    String? recurringTemplateId,
    String? notes,
    int? breakDuration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShiftModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeEmail: employeeEmail ?? this.employeeEmail,
      employeeName: employeeName ?? this.employeeName,
      clientId: clientId ?? this.clientId,
      clientEmail: clientEmail ?? this.clientEmail,
      clientName: clientName ?? this.clientName,
      organizationId: organizationId ?? this.organizationId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      supportItems: supportItems ?? this.supportItems,
      location: location ?? this.location,
      status: status ?? this.status,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringTemplateId: recurringTemplateId ?? this.recurringTemplateId,
      notes: notes ?? this.notes,
      breakDuration: breakDuration ?? this.breakDuration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Calculate shift duration in hours (excluding break)
  double get durationHours {
    final totalMinutes = endTime.difference(startTime).inMinutes - breakDuration;
    return totalMinutes / 60.0;
  }

  /// Check if shift is currently active
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  /// Check if shift has passed
  bool get isPast => DateTime.now().isAfter(endTime);

  /// Check if shift is upcoming
  bool get isUpcoming => DateTime.now().isBefore(startTime);

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}

/// Shift status enum
enum ShiftStatus {
  pending('pending'),
  approved('approved'),
  completed('completed'),
  cancelled('cancelled');

  final String value;
  const ShiftStatus(this.value);

  static ShiftStatus fromString(String value) {
    return ShiftStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => ShiftStatus.pending,
    );
  }
}

/// Location model for GeoJSON Point
@immutable
class ShiftLocation {
  final String type;
  final List<double> coordinates; // [longitude, latitude]

  const ShiftLocation({
    this.type = 'Point',
    required this.coordinates,
  });

  double get longitude => coordinates.isNotEmpty ? coordinates[0] : 0;
  double get latitude => coordinates.length > 1 ? coordinates[1] : 0;

  factory ShiftLocation.fromJson(Map<String, dynamic> json) {
    return ShiftLocation(
      type: json['type']?.toString() ?? 'Point',
      coordinates: (json['coordinates'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [0, 0],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory ShiftLocation.fromLatLng(double latitude, double longitude) {
    return ShiftLocation(coordinates: [longitude, latitude]);
  }
}

/// Support item model for NDIS line items
@immutable
class SupportItemModel {
  final String itemNumber;
  final String itemName;
  final String? unit;
  final String? supportCategoryNumber;
  final String? supportCategoryName;

  const SupportItemModel({
    required this.itemNumber,
    required this.itemName,
    this.unit,
    this.supportCategoryNumber,
    this.supportCategoryName,
  });

  factory SupportItemModel.fromJson(Map<String, dynamic> json) {
    return SupportItemModel(
      itemNumber: json['itemNumber']?.toString() ?? '',
      itemName: json['itemName']?.toString() ?? '',
      unit: json['unit']?.toString(),
      supportCategoryNumber: json['supportCategoryNumber']?.toString(),
      supportCategoryName: json['supportCategoryName']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemNumber': itemNumber,
      'itemName': itemName,
      if (unit != null) 'unit': unit,
      if (supportCategoryNumber != null) 'supportCategoryNumber': supportCategoryNumber,
      if (supportCategoryName != null) 'supportCategoryName': supportCategoryName,
    };
  }
}
