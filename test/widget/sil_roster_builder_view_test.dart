import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';
import 'package:carenest/app/features/sil/views/sil_roster_builder_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Fakes (house style: subclass repository, avoid network)
// ---------------------------------------------------------------------------

class _FakeSILRepository extends SILRepository {
  _FakeSILRepository(this.roster) : super(ApiMethod());

  final SILRoster? roster;
  int publishCalls = 0;

  @override
  Future<SILRoster?> getRoster({
    required String propertyId,
    required String weekStarting,
  }) async =>
      roster;

  @override
  Future<SILRoster> buildRoster({
    required String propertyId,
    required String weekStarting,
  }) async =>
      roster ?? (throw Exception('build unavailable in test'));

  @override
  Future<SILRoster> publishRoster(String id) async {
    publishCalls += 1;
    return roster!;
  }
}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

SILRoster _draftRoster({required List<SILRatioWarning> warnings}) => SILRoster(
      id: 'roster-1',
      propertyId: 'prop-1',
      status: 'draft',
      weekStarting: '2026-10-12',
      ratioWarnings: warnings,
      entries: const [
        SILRosterEntry(
          shiftId: 'shift-1',
          shiftType: 'day',
          requiredStaff: 1,
          assignedStaff: 1,
          compliance: 'ok',
          startTime: '2026-10-12T09:00:00',
          endTime: '2026-10-12T17:00:00',
        ),
        SILRosterEntry(
          shiftId: 'shift-2',
          shiftType: 'active_night',
          requiredStaff: 2,
          assignedStaff: 0,
          compliance: 'understaffed',
          startTime: '2026-10-12T22:00:00',
          endTime: '2026-10-13T06:00:00',
        ),
      ],
    );

Widget _buildApp(SILRepository repo) {
  return ProviderScope(
    overrides: [
      silRepositoryProvider.overrideWith((ref) => repo),
      app_providers.organizationIdProvider.overrideWithValue('org-1'),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SILRosterBuilderView(
        propertyId: 'prop-1',
        propertyName: 'Mock House',
      ),
    ),
  );
}

void main() {
  testWidgets(
    'renders title, week, entries and understaffed ratio warning for a draft roster',
    (tester) async {
      final repo = _FakeSILRepository(_draftRoster(warnings: const [
        SILRatioWarning(
          role: 'ratio',
          message: 'active_night shift on 2026-10-12 is understaffed (required 2, assigned 0).',
        ),
      ]));
      await tester.pumpWidget(_buildApp(repo));
      await tester.pumpAndSettle();

      // AppBar header uses the property name.
      expect(find.text('Roster · Mock House'), findsOneWidget);
      // Draft rosters expose the publish action.
      expect(find.text('Publish'), findsOneWidget);
      // Ratio compliance surfaces both the header and the server message.
      expect(find.text('Ratio warnings'), findsOneWidget);
      expect(
        find.text(
            '• active_night shift on 2026-10-12 is understaffed (required 2, assigned 0).'),
        findsOneWidget,
      );
      // Fully staffed day entry renders at 1/1 with its compliance chip.
      expect(find.textContaining('staff 1/1'), findsOneWidget);
      expect(find.text('ok'), findsOneWidget);
      // Understaffed night entry renders at 0/2 with an assign affordance
      // (unassigned entries expose Assign instead of a compliance chip).
      expect(find.textContaining('staff 0/2'), findsOneWidget);
      expect(find.text('Assign'), findsOneWidget);
    },
  );

  testWidgets(
    'published rosters hide the publish action but keep entries visible',
    (tester) async {
      final draft = _draftRoster(warnings: const []);
      final repo = _FakeSILRepository(
        SILRoster(
          id: draft.id,
          propertyId: draft.propertyId,
          status: 'published',
          weekStarting: draft.weekStarting,
          ratioWarnings: draft.ratioWarnings,
          entries: draft.entries,
        ),
      );
      await tester.pumpWidget(_buildApp(repo));
      await tester.pumpAndSettle();

      expect(find.text('Publish'), findsNothing);
      expect(find.textContaining('staff 1/1'), findsOneWidget);
      expect(find.text('Ratio warnings'), findsNothing);
    },
  );

  testWidgets(
    'empty week shows the build-from-shifts hint',
    (tester) async {
      final repo = _FakeSILRepository(null);
      await tester.pumpWidget(_buildApp(repo));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('No roster for this week'),
        findsOneWidget,
      );
      expect(find.text('Publish'), findsNothing);
    },
  );
}
