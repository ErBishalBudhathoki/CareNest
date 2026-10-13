import 'package:carenest/app/features/stakeholders/models/stakeholder_models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase 5: verify stakeholder / care-team JSON parsing.
void main() {
  test('Stakeholder parses permissions', () {
    final s = Stakeholder.fromJson({
      'id': 's1',
      'type': 'plan_manager',
      'name': 'PM Co',
      'email': 'pm@x.com',
      'company': 'PM Pty',
      'isActive': true,
      'permissions': {'viewInvoices': true, 'approveServices': true},
    });

    expect(s.id, 's1');
    expect(s.type, 'plan_manager');
    expect(s.company, 'PM Pty');
    expect(s.permissions.viewInvoices, true);
    expect(s.permissions.approveServices, true);
    expect(s.permissions.editProfile, false); // default
  });

  test('ClientCareTeam parses nested care team entries', () {
    final team = ClientCareTeam.fromJson({
      'clientId': 'c1',
      'fundingType': 'ndia_managed',
      'careTeam': [
        {
          'linkRole': 'support_coordinator',
          'isPrimary': true,
          'stakeholder': {'id': 's2', 'type': 'support_coordinator', 'name': 'SC Co'},
        },
      ],
    });

    expect(team.fundingType, 'ndia_managed');
    expect(team.careTeam, hasLength(1));
    expect(team.careTeam.first.isPrimary, true);
    expect(team.careTeam.first.stakeholder.name, 'SC Co');
  });

  test('Stakeholder defaults are safe when fields are absent', () {
    final s = Stakeholder.fromJson({'id': 's3', 'name': 'Bare'});
    expect(s.type, 'other');
    expect(s.email, '');
    expect(s.isActive, true);
    expect(s.permissions.viewAppointments, false);
  });
}
