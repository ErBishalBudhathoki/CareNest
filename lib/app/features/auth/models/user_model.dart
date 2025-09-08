import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/foundation.dart';

class User {
  late final String id;
  late final String organizationId;
  late final String name;
  late final String email;
  late final String phone;
  late final String? profilePic;
  late final UserRole role;

  User({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.email,
    required this.phone,
    this.profilePic,
    required this.role,
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
        id: json['id']?.toString() ?? '',
        organizationId: organizationId,
        name: name,
        email: json['email']?.toString() ?? '',
        phone: json['phone']?.toString() ?? '',
        profilePic: json['profilePic']?.toString(),
        role: json['role'] == 'admin' ? UserRole.admin : UserRole.normal,
      );
    } catch (e) {
      debugPrint('Error parsing user data: $e');
      debugPrint('JSON data: $json');
      rethrow;
    }
  }
}
