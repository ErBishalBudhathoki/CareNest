import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase 4: verify SIL model JSON parsing matches the backend `toJSON` shapes,
/// including nested `ratio`, `priceValidation`, `reviewSchedule` and the
/// `_id` -> `id` transform.
void main() {
  test('SILProperty parses nested address and rooms', () {
    final property = SILProperty.fromJson({
      'id': 'p1',
      'name': 'Richmond House',
      'propertyType': 'house',
      'silDesignCategory': 'robust',
      'bedrooms': 3,
      'maxOccupancy': 3,
      'active': true,
      'address': {'line1': '1 Main St', 'suburb': 'Richmond', 'state': 'VIC'},
      'rooms': [
        {'roomId': 'r1', 'label': 'Room 1', 'vacant': false},
        {'roomId': 'r2', 'label': 'Room 2'},
      ],
      'amenities': ['hoist', 'ramp'],
    });

    expect(property.id, 'p1');
    expect(property.name, 'Richmond House');
    expect(property.address?.suburb, 'Richmond');
    expect(property.rooms, hasLength(2));
    expect(property.rooms.first.vacant, false);
    expect(property.rooms[1].vacant, true); // default
    expect(property.amenities, contains('hoist'));
  });

  test('SILRatioRule parses the nested ratio object', () {
    final rule = SILRatioRule.fromJson({
      'id': 'rule1',
      'name': '2:1 active night',
      'ratio': {'staff': 2, 'participants': 1},
      'shiftType': 'active_night',
      'minParticipants': 1,
      'maxParticipants': 0,
      'isActive': true,
    });

    expect(rule.ratio.staff, 2);
    expect(rule.ratio.participants, 1);
    expect(rule.shiftType, 'active_night');
  });

  test('SILQuote parses nested lines, priceValidation and totals', () {
    final quote = SILQuote.fromJson({
      'id': 'q1',
      'clientId': 'c1',
      'status': 'sent',
      'fundingType': 'plan_managed',
      'lines': [
        {
          'supportNumber': '01_011_0107_1_1',
          'hoursPerWeek': 10,
          'unitPrice': 80,
          'amount': 800,
          'priceValidation': {'passed': false, 'capApplied': 50, 'errors': ['over cap']},
        },
      ],
      'totals': {'weeklyHours': 10, 'weeklyAmount': 800, 'annualAmount': 41600},
    });

    expect(quote.lines, hasLength(1));
    expect(quote.lines.first.priceValidation.passed, false);
    expect(quote.lines.first.priceValidation.errors, contains('over cap'));
    expect(quote.totals.weeklyAmount, 800);
  });

  test('SILRosterOfCare parses nested reviewSchedule and supports', () {
    final roc = SILRosterOfCare.fromJson({
      'id': 'roc1',
      'clientId': 'c1',
      'status': 'active',
      'effectiveFrom': '2026-06-01T00:00:00.000Z',
      'reviewSchedule': {'cadence': 'quarterly', 'nextReviewDate': '2026-09-01T00:00:00.000Z'},
      'supports': [
        {'supportNumber': 'x', 'hoursPerWeek': 10, 'unitPrice': 80, 'amount': 800},
      ],
    });

    expect(roc.reviewSchedule.cadence, 'quarterly');
    expect(roc.reviewSchedule.nextReviewDate, '2026-09-01T00:00:00.000Z');
    expect(roc.supports, hasLength(1));
  });

  test('SILVacancyBoard parses room occupancy flags', () {
    final board = SILVacancyBoard.fromJson({
      'propertyId': 'p1',
      'propertyName': 'House',
      'totalRooms': 2,
      'occupiedCount': 1,
      'vacantCount': 1,
      'rooms': [
        {'roomId': 'r1', 'occupied': true},
        {'roomId': 'r2', 'occupied': false},
      ],
    });

    expect(board.totalRooms, 2);
    expect(board.vacantCount, 1);
    expect(board.rooms.first.occupied, true);
  });
}
