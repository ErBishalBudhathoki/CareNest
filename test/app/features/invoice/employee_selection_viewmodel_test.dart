import 'package:carenest/app/features/invoice/viewmodels/employee_selection_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

/// Locks the client display name used under each selected employee.
///
/// Regression: `getUserAssignments` returns the assignment fields plus a joined
/// `clientDetails` object, and has never carried a `clientName` field. The
/// mapper read only `assignment['clientName']`, so the name resolved to null and
/// fell through to the email, rendering the address as both the card heading
/// and its subtitle.
void main() {
  Map<String, dynamic> assignment({
    Object? details,
    Map<String, dynamic> extra = const {},
  }) => {
    'clientId': 'c1',
    'clientEmail': 'jane.doe@example.com',
    'clientDetails': ?details,
    ...extra,
  };

  group('resolves the client full name', () {
    test('from joined clientDetails as a Map', () {
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(
          details: {
            'clientEmail': 'jane.doe@example.com',
            'clientFirstName': 'Jane',
            'clientLastName': 'Doe',
          },
        ),
      );

      expect(name, 'Jane Doe');
    });

    test('from joined clientDetails as a single-element List', () {
      // $unwind usually flattens to a Map, but the shape is not guaranteed.
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(
          details: [
            {'clientFirstName': 'Jane', 'clientLastName': 'Doe'},
          ],
        ),
      );

      expect(name, 'Jane Doe');
    });

    test('from fields flattened onto the assignment', () {
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(extra: {'clientFirstName': 'Jane', 'clientLastName': 'Doe'}),
      );

      expect(name, 'Jane Doe');
    });

    test('prefers an explicit clientName when one is present', () {
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(
          details: {'clientFirstName': 'Jane', 'clientLastName': 'Doe'},
          extra: {'clientName': 'Dr Jane Doe'},
        ),
      );

      expect(name, 'Dr Jane Doe');
    });

    test('uses the first name alone when there is no last name', () {
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(details: {'clientFirstName': 'Cher'}),
      );

      expect(name, 'Cher');
    });

    test('falls back to business name before the email', () {
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(extra: {'businessName': 'Acme Home Care'}),
      );

      expect(name, 'Acme Home Care');
    });
  });

  group('never renders the email as the heading when a name exists', () {
    test('the regression case: no clientName field anywhere', () {
      // This is the exact live payload shape. Old code read
      // assignment['clientName'] -> null -> fell back to clientEmail, so the
      // heading and the subtitle both showed jane.doe@example.com.
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(
          details: {
            'clientEmail': 'jane.doe@example.com',
            'clientFirstName': 'Jane',
            'clientLastName': 'Doe',
          },
        ),
      );

      expect(name, isNot('jane.doe@example.com'));
      expect(name, contains('Jane'));
    });
  });

  group('degrades safely when there is genuinely nothing', () {
    test('uses the assignment email when no name exists anywhere', () {
      final name = EmployeeSelectionViewModel.resolveClientName({
        'clientId': 'c1',
        'clientEmail': 'no-name@example.com',
        'clientDetails': {'clientEmail': 'no-name@example.com'},
      });

      expect(name, 'no-name@example.com');
    });

    test('uses the clientDetails email when the assignment omits it', () {
      final name = EmployeeSelectionViewModel.resolveClientName({
        'clientId': 'c1',
        'clientDetails': {'clientEmail': 'details-only@example.com'},
      });

      expect(name, 'details-only@example.com');
    });

    test('ignores a whitespace-only name', () {
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(extra: {'clientName': '   '}),
      );

      expect(name, 'jane.doe@example.com');
    });

    test('returns Unknown when the email is missing too', () {
      final name = EmployeeSelectionViewModel.resolveClientName({
        'clientId': 'c1',
      });

      expect(name, 'Unknown');
    });

    test('tolerates an empty clientDetails list', () {
      final name = EmployeeSelectionViewModel.resolveClientName(
        assignment(details: []),
      );

      expect(name, 'jane.doe@example.com');
    });
  });
}
