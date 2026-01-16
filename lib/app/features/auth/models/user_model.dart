import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/foundation.dart';

class RatesModel {
  final double baseRate;
  final double saturdayRate;
  final double sundayRate;
  final double publicHolidayRate;
  final double overtimeRate;
  final double overtimeRate2;
  final double nightShiftRate;
  final double eveningShiftRate;

  RatesModel({
    required this.baseRate,
    required this.saturdayRate,
    required this.sundayRate,
    required this.publicHolidayRate,
    required this.overtimeRate,
    required this.overtimeRate2,
    required this.nightShiftRate,
    required this.eveningShiftRate,
  });

  factory RatesModel.fromJson(Map<String, dynamic> json) {
    return RatesModel(
      baseRate: (json['baseRate'] as num?)?.toDouble() ?? 0.0,
      saturdayRate: (json['saturdayRate'] as num?)?.toDouble() ?? 0.0,
      sundayRate: (json['sundayRate'] as num?)?.toDouble() ?? 0.0,
      publicHolidayRate: (json['publicHolidayRate'] as num?)?.toDouble() ?? 0.0,
      overtimeRate: (json['overtimeRate'] as num?)?.toDouble() ?? 0.0,
      overtimeRate2: (json['overtimeRate2'] as num?)?.toDouble() ?? 0.0,
      nightShiftRate: (json['nightShiftRate'] as num?)?.toDouble() ?? 0.0,
      eveningShiftRate: (json['eveningShiftRate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class User {
  late final String id;
  late final String organizationId;
  late final String name;
  late final String email;
  late final String phone;
  late final String? profilePic;
  late final UserRole role;
  late final String? jobRole;
  late final double payRate;
  late final RatesModel? detailedRates;
  late final List<String> activeAllowances;
  late final String? payType;
  late final String? stream;
  late final String? classificationLevel;
  late final String? payPoint;
  late final String? employmentType;

  User({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.email,
    required this.phone,
    this.profilePic,
    required this.role,
    this.jobRole,
    this.payRate = 0.0,
    this.detailedRates,
    this.activeAllowances = const [],
    this.payType,
    this.stream,
    this.classificationLevel,
    this.payPoint,
    this.employmentType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      // Combine firstName and lastName if 'name' is not present
      String name = '';
      if (json['name'] != null && json['name'].toString().isNotEmpty) {
        name = json['name'].toString();
      } else if (json['firstName'] != null || json['lastName'] != null) {
        name =
            ((json['firstName'] ?? '') + ' ' + (json['lastName'] ?? '')).trim();
      }

      // Handle organizationId - it might be directly in json or null
      String organizationId = '';
      if (json['organizationId'] != null &&
          json['organizationId'].toString().isNotEmpty) {
        organizationId = json['organizationId'].toString();
      }

      return User(
        id: (json['id'] ?? json['_id'] ?? json['userId'])?.toString() ?? '',
        organizationId: organizationId,
        name: name,
        email: json['email']?.toString() ?? '',
        phone: json['phone']?.toString() ?? '',
        profilePic: json['profilePic']?.toString(),
        role: json['role'] == 'admin' ? UserRole.admin : UserRole.normal,
        jobRole: json['jobRole']?.toString(),
        payRate: (json['payRate'] as num?)?.toDouble() ?? 0.0,
        detailedRates: json['rates'] != null ? RatesModel.fromJson(json['rates']) : null,
        activeAllowances: (json['activeAllowances'] as List?)?.map((e) => e.toString()).toList() ?? [],
        payType: json['payType']?.toString(),
        stream: json['stream']?.toString(),
        classificationLevel: json['classificationLevel']?.toString(),
        payPoint: json['payPoint']?.toString(),
        employmentType: json['employmentType']?.toString(),
      );
    } catch (e) {
      debugPrint('Error parsing user data: $e');
      debugPrint('JSON data: $json');
      rethrow;
    }
  }
}
