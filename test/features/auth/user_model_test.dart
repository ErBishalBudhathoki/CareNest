import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Model Tests', () {
    test('fromJson should parse standard user correctly', () {
      final json = {
        'id': 'user_123',
        'organizationId': 'org_456',
        'name': 'Test User',
        'email': 'test@example.com',
        'phone': '1234567890',
        'role': 'user',
        'permissions': ['read', 'write'],
      };

      final user = User.fromJson(json);

      expect(user.id, 'user_123');
      expect(user.organizationId, 'org_456');
      expect(user.name, 'Test User');
      expect(user.email, 'test@example.com');
      expect(user.role, UserRole.employee);
      expect(user.permissions, containsAll(['read', 'write']));
    });

    test('fromJson should handle _id variant', () {
      final json = {
        '_id': 'user_123',
        'organizationId': 'org_456',
        'name': 'Test User',
        'email': 'test@example.com',
        'phone': '1234567890',
        'role': 'admin',
      };

      final user = User.fromJson(json);

      expect(user.id, 'user_123');
      expect(user.role, UserRole.admin);
    });

    test('fromJson should combine first and last name', () {
      final json = {
        'id': 'user_123',
        'organizationId': 'org_456',
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'john@example.com',
        'phone': '123',
        'role': 'user',
      };

      final user = User.fromJson(json);

      expect(user.name, 'John Doe');
    });

    test(
      'fromJson should handle null organizationId gracefully (but maybe warn)',
      () {
        final json = {
          'id': 'user_123',
          'name': 'Test User',
          'email': 'test@example.com',
          'phone': '123',
          'role': 'user',
        };

        final user = User.fromJson(json);

        expect(user.organizationId, '');
      },
    );

    test('fromJson should parse roles correctly', () {
      expect(
        User.fromJson({
          'id': '1',
          'organizationId': '1',
          'name': 'a',
          'email': 'a',
          'phone': '1',
          'role': 'admin',
        }).role,
        UserRole.admin,
      );
      expect(
        User.fromJson({
          'id': '1',
          'organizationId': '1',
          'name': 'a',
          'email': 'a',
          'phone': '1',
          'role': 'client',
        }).role,
        UserRole.client,
      );
      expect(
        User.fromJson({
          'id': '1',
          'organizationId': '1',
          'name': 'a',
          'email': 'a',
          'phone': '1',
          'role': 'unknown',
        }).role,
        UserRole.employee,
      );
      expect(
        User.fromJson({
          'id': '1',
          'organizationId': '1',
          'name': 'a',
          'email': 'a',
          'phone': '1',
          'role': null,
        }).role,
        UserRole.employee,
      );
    });

    test('fromJson should parse detailed rates', () {
      final json = {
        'id': 'user_123',
        'organizationId': 'org_1',
        'name': 'Test',
        'email': 't@t.com',
        'phone': '123',
        'role': 'user',
        'rates': {'baseRate': 25.50, 'saturdayRate': 30.00},
      };

      final user = User.fromJson(json);

      expect(user.detailedRates, isNotNull);
      expect(user.detailedRates!.baseRate, 25.50);
      expect(user.detailedRates!.saturdayRate, 30.00);
      expect(user.detailedRates!.sundayRate, 0.0); // Default
    });
  });
}
