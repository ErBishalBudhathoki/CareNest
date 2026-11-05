import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/app/features/worker/views/widgets/worker_shift_card.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Milestone 4.3: Widget tests verifying that Irregular SIL / crisis shifts
/// display prominent crisis badges, justification notes, and incident report references.
void main() {
  group('WorkerShiftCard Irregular SIL Tests', () {
    testWidgets(
      'renders IRREGULAR SIL / CRISIS STAFFING badge and justification notes',
      (tester) async {
        final irregularShift = ShiftModel(
          id: 'shift_irr_test_1',
          organizationId: 'org_test_1',
          startTime: DateTime.utc(2026, 3, 10, 14, 0),
          endTime: DateTime.utc(2026, 3, 10, 20, 0),
          status: ShiftStatus.approved,
          clientName: 'Charlie Brown',
          isIrregularSil: true,
          irregularSilReason: 'crisis',
          crisisJustificationNotes:
              'Participant escalation requiring emergency PRN staffing',
          incidentReportReference: 'INC-2026-55',
        );

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: WorkerShiftCard(shift: irregularShift)),
          ),
        );

        await tester.pumpAndSettle();

        // Verify the Irregular SIL / crisis badge appears
        expect(find.text('IRREGULAR SIL / CRISIS STAFFING'), findsOneWidget);
        expect(
          find.text('Participant escalation requiring emergency PRN staffing'),
          findsOneWidget,
        );
        expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
      },
    );

    testWidgets('does not render crisis badge when shift is regular', (
      tester,
    ) async {
      final regularShift = ShiftModel(
        id: 'shift_reg_test_1',
        organizationId: 'org_test_1',
        startTime: DateTime.utc(2026, 3, 10, 9, 0),
        endTime: DateTime.utc(2026, 3, 10, 17, 0),
        status: ShiftStatus.approved,
        clientName: 'Lucy van Pelt',
        isIrregularSil: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: WorkerShiftCard(shift: regularShift)),
        ),
      );

      await tester.pumpAndSettle();

      // Crisis badge should not be present
      expect(find.text('IRREGULAR SIL / CRISIS STAFFING'), findsNothing);
      expect(find.byIcon(Icons.warning_amber_rounded), findsNothing);
    });
  });
}
