import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:carenest/app/features/sil/repositories/sil_repository.dart';
import 'package:carenest/app/features/sil/views/sil_absence_sheet.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class _NoopApiMethod extends ApiMethod {}

/// Fake repository returning canned absence rows; records calls for assertions.
class _FakeAbsenceRepository extends SILRepository {
  _FakeAbsenceRepository({this.rows = const [], this.throwOnLoad = false})
      : super(_NoopApiMethod());

  List<Map<String, dynamic>> rows;
  final bool throwOnLoad;
  final List<Map<String, dynamic>> recordedWith = [];
  final List<Map<String, dynamic>> endedWith = [];

  @override
  Future<List<Map<String, dynamic>>> listSilAbsences({
    String? occupancyId,
    String? clientId,
    String? propertyId,
  }) async {
    if (throwOnLoad) {
      throw Exception('boom');
    }
    return List<Map<String, dynamic>>.from(rows);
  }

  @override
  Future<Map<String, dynamic>> recordSilAbsence(
    String occupancyId, {
    required DateTime startDate,
    DateTime? endDate,
    String? reason,
    String? notes,
    int? maxClaimableDays,
  }) async {
    final row = <String, dynamic>{
      '_id': 'abs_${rows.length + 1}',
      'occupancyId': occupancyId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'reason': reason ?? 'hospital',
      'notes': notes ?? '',
      'maxClaimableDays': maxClaimableDays ?? 28,
      'claimedDays': 0,
    };
    recordedWith.add(row);
    rows = [row, ...rows];
    return row;
  }

  @override
  Future<Map<String, dynamic>> endSilAbsence(
    String occupancyId,
    String absenceId, {
    DateTime? endDate,
  }) async {
    endedWith.add({
      'occupancyId': occupancyId,
      'absenceId': absenceId,
      'endDate': endDate,
    });
    rows = rows
        .map((row) => row['_id'] == absenceId
            ? {...row, 'endDate': (endDate ?? DateTime.now()).toIso8601String()}
            : row)
        .toList();
    return {'_id': absenceId};
  }
}

Map<String, dynamic> hospitalAbsence({
  String id = 'abs_1',
  String? endDate,
  int maxClaimableDays = 28,
  int claimedDays = 3,
}) =>
    {
      '_id': id,
      'occupancyId': 'occ_1',
      'startDate': '2026-10-01T00:00:00.000Z',
      'endDate': endDate,
      'reason': 'hospital',
      'notes': 'Admitted — cardiology',
      'maxClaimableDays': maxClaimableDays,
      'claimedDays': claimedDays,
    };

Widget pumpSheet(_FakeAbsenceRepository repo) {
  return ProviderScope(
    overrides: [silRepositoryProvider.overrideWithValue(repo)],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SilAbsenceSheet(
          occupancyId: 'occ_1',
          residentLabel: 'Room 2',
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('lists existing absences with remaining leave allowance', (tester) async {
    final repo = _FakeAbsenceRepository(rows: [hospitalAbsence()]);

    await tester.pumpWidget(pumpSheet(repo));
    await tester.pumpAndSettle();

    expect(find.text('Hospital'), findsOneWidget);
    expect(find.text('Claimed 3 of 28 days'), findsOneWidget);
    expect(find.textContaining('→ Ongoing'), findsOneWidget);
    expect(find.textContaining('cardiology'), findsOneWidget);
  });

  testWidgets('record flow posts a new absence and refreshes the list', (tester) async {
    final repo = _FakeAbsenceRepository();

    await tester.pumpWidget(pumpSheet(repo));
    await tester.pumpAndSettle();

    expect(find.text('No absences recorded for this resident.'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Record absence'));
    await tester.pumpAndSettle();

    // Save with the defaults (hospital, ongoing, 28 days).
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(repo.recordedWith, hasLength(1));
    expect(repo.recordedWith.first['reason'], equals('hospital'));
    expect(repo.recordedWith.first['maxClaimableDays'], equals(28));
    expect(repo.recordedWith.first['endDate'], isNull);
    expect(find.text('Absence recorded'), findsOneWidget);
  });

  testWidgets('end flow closes an ongoing absence after confirmation', (tester) async {
    final repo = _FakeAbsenceRepository(rows: [hospitalAbsence()]);

    await tester.pumpWidget(pumpSheet(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, 'End absence'));
    await tester.pumpAndSettle();

    // Confirm in the dialog.
    final dialog = find.byType(AlertDialog);
    expect(dialog, findsOneWidget);
    await tester.tap(
      find.descendant(of: dialog, matching: find.widgetWithText(FilledButton, 'End absence')),
    );
    await tester.pumpAndSettle();

    expect(repo.endedWith, hasLength(1));
    expect(repo.endedWith.first['absenceId'], equals('abs_1'));
    expect(find.text('Absence ended'), findsOneWidget);
  });

  testWidgets('surfaces a load failure with a retry action', (tester) async {
    final repo = _FakeAbsenceRepository(throwOnLoad: true);

    await tester.pumpWidget(pumpSheet(repo));
    await tester.pumpAndSettle();

    expect(find.textContaining('Could not load absences'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Retry'), findsOneWidget);
  });
}
