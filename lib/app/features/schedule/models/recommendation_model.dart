// Recommendation Model
// Represents an AI-powered employee recommendation for shift assignment
//
// @file lib/app/features/schedule/models/recommendation_model.dart

import 'package:flutter/foundation.dart';

/// Model representing an employee recommendation with match scores
@immutable
class RecommendationModel {
  final String employeeId;
  final String employeeEmail;
  final String employeeName;
  final String firstName;
  final String lastName;
  final int matchScore;       // Composite score 0-100
  final int skillScore;       // Skill match score 0-100
  final int availabilityScore; // Availability score 0-100
  final int distanceScore;    // Proximity score 0-100
  final double? distanceKm;   // Distance in kilometers
  final List<String> skills;  // Employee's skills

  const RecommendationModel({
    required this.employeeId,
    required this.employeeEmail,
    required this.employeeName,
    this.firstName = '',
    this.lastName = '',
    required this.matchScore,
    this.skillScore = 0,
    this.availabilityScore = 0,
    this.distanceScore = 0,
    this.distanceKm,
    this.skills = const [],
  });

  /// Create from JSON response
  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      employeeId: json['employeeId']?.toString() ?? '',
      employeeEmail: json['employeeEmail']?.toString() ?? '',
      employeeName: json['employeeName']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      matchScore: (json['matchScore'] as num?)?.toInt() ?? 0,
      skillScore: (json['skillScore'] as num?)?.toInt() ?? 0,
      availabilityScore: (json['availabilityScore'] as num?)?.toInt() ?? 0,
      distanceScore: (json['distanceScore'] as num?)?.toInt() ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'employeeEmail': employeeEmail,
      'employeeName': employeeName,
      'firstName': firstName,
      'lastName': lastName,
      'matchScore': matchScore,
      'skillScore': skillScore,
      'availabilityScore': availabilityScore,
      'distanceScore': distanceScore,
      if (distanceKm != null) 'distanceKm': distanceKm,
      'skills': skills,
    };
  }

  /// Get initials for avatar display
  String get initials {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '${firstName[0]}${lastName[0]}'.toUpperCase();
    }
    if (employeeName.isNotEmpty) {
      final parts = employeeName.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return employeeName[0].toUpperCase();
    }
    if (employeeEmail.isNotEmpty) {
      return employeeEmail[0].toUpperCase();
    }
    return '?';
  }

  /// Get display name
  String get displayName {
    if (employeeName.isNotEmpty) return employeeName;
    if (firstName.isNotEmpty || lastName.isNotEmpty) {
      return '$firstName $lastName'.trim();
    }
    return employeeEmail;
  }

  /// Get formatted distance string
  String get formattedDistance {
    if (distanceKm == null) return 'N/A';
    if (distanceKm! < 1) {
      return '${(distanceKm! * 1000).round()}m';
    }
    return '${distanceKm!.toStringAsFixed(1)}km';
  }

  /// Get match score color suggestion (for UI)
  /// Returns a score tier: 'excellent', 'good', 'fair', 'poor'
  String get scoreTier {
    if (matchScore >= 80) return 'excellent';
    if (matchScore >= 60) return 'good';
    if (matchScore >= 40) return 'fair';
    return 'poor';
  }
}

/// Response wrapper for recommendations API
@immutable
class RecommendationsResponse {
  final bool success;
  final List<RecommendationModel> recommendations;
  final int totalCandidates;
  final int availableCandidates;
  final String? message;

  const RecommendationsResponse({
    required this.success,
    this.recommendations = const [],
    this.totalCandidates = 0,
    this.availableCandidates = 0,
    this.message,
  });

  factory RecommendationsResponse.fromJson(Map<String, dynamic> json) {
    return RecommendationsResponse(
      success: json['success'] == true,
      recommendations: (json['recommendations'] as List<dynamic>?)
              ?.map((e) => RecommendationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalCandidates: (json['totalCandidates'] as num?)?.toInt() ?? 0,
      availableCandidates: (json['availableCandidates'] as num?)?.toInt() ?? 0,
      message: json['message']?.toString(),
    );
  }
}

/// Conflict information model
@immutable
class ConflictModel {
  final String type; // 'shift', 'assignment', 'activeTimer'
  final String? shiftId;
  final String? assignmentId;
  final String? clientEmail;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? message;

  const ConflictModel({
    required this.type,
    this.shiftId,
    this.assignmentId,
    this.clientEmail,
    this.startTime,
    this.endTime,
    this.message,
  });

  factory ConflictModel.fromJson(Map<String, dynamic> json) {
    return ConflictModel(
      type: json['type']?.toString() ?? 'unknown',
      shiftId: json['shiftId']?.toString(),
      assignmentId: json['assignmentId']?.toString(),
      clientEmail: json['clientEmail']?.toString(),
      startTime: json['startTime'] != null
          ? DateTime.tryParse(json['startTime'].toString())
          : null,
      endTime: json['endTime'] != null
          ? DateTime.tryParse(json['endTime'].toString())
          : null,
      message: json['message']?.toString(),
    );
  }
}

/// Conflict check response
@immutable
class ConflictCheckResponse {
  final bool success;
  final bool hasConflict;
  final List<ConflictModel> conflicts;
  final String? message;

  const ConflictCheckResponse({
    required this.success,
    required this.hasConflict,
    this.conflicts = const [],
    this.message,
  });

  factory ConflictCheckResponse.fromJson(Map<String, dynamic> json) {
    return ConflictCheckResponse(
      success: json['success'] == true,
      hasConflict: json['hasConflict'] == true,
      conflicts: (json['conflicts'] as List<dynamic>?)
              ?.map((e) => ConflictModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      message: json['message']?.toString(),
    );
  }
}
