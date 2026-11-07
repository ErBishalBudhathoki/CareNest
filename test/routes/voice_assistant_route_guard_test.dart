import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/voice_assistant/views/voice_assistant_view.dart';
import 'package:flutter_test/flutter_test.dart';

/// Regression cover for the direct-push bypass: the voice assistant opens
/// admin-only widgets with MaterialPageRoute, which AppPages.guardAdminRoute
/// cannot see. These tests assert the pure decision helper that gates it.
void main() {
  test('every admin-only voice destination is refused for non-admin roles', () {
    for (final role in [null, UserRole.employee, UserRole.client, UserRole.family]) {
      for (final destination in adminOnlyVoiceRoutes) {
        expect(
          isVoiceDestinationAllowed(destination, role),
          isFalse,
          reason: '$destination must be refused for $role',
        );
      }
    }
  });

  test('every admin-only voice destination is allowed for an admin', () {
    for (final destination in adminOnlyVoiceRoutes) {
      expect(isVoiceDestinationAllowed(destination, UserRole.admin), isTrue);
    }
  });

  test('shared/self-service destinations stay reachable for employees', () {
    for (final role in [UserRole.employee, UserRole.client, UserRole.family]) {
      expect(isVoiceDestinationAllowed('notification_center', role), isTrue);
    }
  });

  test('an empty or null suggested route is refused', () {
    expect(isVoiceDestinationAllowed(null, UserRole.admin), isFalse);
    expect(isVoiceDestinationAllowed('', UserRole.admin), isFalse);
  });

  test('the protected set covers the known admin surfaces', () {
    expect(
      adminOnlyVoiceRoutes,
      containsAll(<String>[
        'client_list',
        'invoice_list',
        'schedule_dashboard',
        'assign_c2e',
        'assignment_schedule',
        'admin_dashboard',
      ]),
    );
    expect(adminOnlyVoiceRoutes.contains('notification_center'), isFalse);
  });
}
