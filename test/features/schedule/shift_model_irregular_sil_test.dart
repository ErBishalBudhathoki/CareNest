import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:flutter_test/flutter_test.dart';

/// Milestone 4.3: Verify ShiftModel irregular SIL / crisis shift serialization,
/// deserialization, and copyWith operations.
void main() {
  group('ShiftModel Irregular SIL Tests', () {
    test('deserializes irregular SIL fields from JSON', () {
      final json = {
        'id': 'shift_irr_1',
        'organizationId': 'org_1',
        'startTime': '2026-03-10T14:00:00.000Z',
        'endTime': '2026-03-10T18:00:00.000Z',
        'status': 'completed',
        'isIrregularSil': true,
        'irregularSilReason': 'crisis',
        'crisisJustificationNotes': 'Acute behavioral incident requiring immediate 1:1 intervention',
        'incidentReportReference': 'INC-2026-0042',
      };

      final shift = ShiftModel.fromJson(json);

      expect(shift.id, 'shift_irr_1');
      expect(shift.isIrregularSil, isTrue);
      expect(shift.irregularSilReason, 'crisis');
      expect(
        shift.crisisJustificationNotes,
        'Acute behavioral incident requiring immediate 1:1 intervention',
      );
      expect(shift.incidentReportReference, 'INC-2026-0042');
    });

    test('serializes irregular SIL fields to JSON', () {
      final shift = ShiftModel(
        id: 'shift_irr_2',
        organizationId: 'org_1',
        startTime: DateTime.utc(2026, 3, 11, 10, 0),
        endTime: DateTime.utc(2026, 3, 11, 14, 0),
        isIrregularSil: true,
        irregularSilReason: 'hospital_discharge',
        crisisJustificationNotes: 'Emergency discharge support after surgery',
        incidentReportReference: 'HOSP-DIS-99',
      );

      final json = shift.toJson();

      expect(json['isIrregularSil'], isTrue);
      expect(json['irregularSilReason'], 'hospital_discharge');
      expect(json['crisisJustificationNotes'], 'Emergency discharge support after surgery');
      expect(json['incidentReportReference'], 'HOSP-DIS-99');
    });

    test('defaults irregular SIL fields safely when omitted', () {
      final json = {
        'id': 'shift_normal',
        'organizationId': 'org_1',
        'startTime': '2026-03-10T09:00:00.000Z',
        'endTime': '2026-03-10T17:00:00.000Z',
      };

      final shift = ShiftModel.fromJson(json);

      expect(shift.isIrregularSil, isFalse);
      expect(shift.irregularSilReason, isNull);
      expect(shift.crisisJustificationNotes, isNull);
      expect(shift.incidentReportReference, isNull);
    });

    test('copyWith updates irregular SIL fields correctly', () {
      final initial = ShiftModel(
        id: 'shift_copy',
        organizationId: 'org_1',
        startTime: DateTime.utc(2026, 3, 12, 8, 0),
        endTime: DateTime.utc(2026, 3, 12, 16, 0),
        isIrregularSil: false,
      );

      final updated = initial.copyWith(
        isIrregularSil: true,
        irregularSilReason: 'prn_behavioral',
        crisisJustificationNotes: 'PRN support escalated by clinician',
      );

      expect(updated.isIrregularSil, isTrue);
      expect(updated.irregularSilReason, 'prn_behavioral');
      expect(updated.crisisJustificationNotes, 'PRN support escalated by clinician');
      expect(updated.id, 'shift_copy');
    });
  });
}

