import 'package:carenest/app/features/admin/utils/command_desk_prefs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CommandDeskPrefs ordering (pure logic)', () {
    const titles = ['Invoices', 'Training', 'Org', 'Intel', 'Config'];

    test('original order when toggle is off', () {
      expect(
        CommandDeskPrefs.orderedSectionIndices(
          categoryTitles: titles,
          lastUsedByCategory: {'Intel': 300, 'Invoices': 100},
          sortByRecent: false,
        ),
        [0, 1, 2, 3, 4],
      );
    });

    test('original order when toggle is on but nothing used', () {
      expect(
        CommandDeskPrefs.orderedSectionIndices(
          categoryTitles: titles,
          lastUsedByCategory: {},
          sortByRecent: true,
        ),
        [0, 1, 2, 3, 4],
      );
    });

    test('used sections float first, most recent first', () {
      expect(
        CommandDeskPrefs.orderedSectionIndices(
          categoryTitles: titles,
          lastUsedByCategory: {'Intel': 300, 'Invoices': 100, 'Org': 200},
          sortByRecent: true,
        ),
        [3, 2, 0, 1, 4],
      );
    });

    test('ties keep original positions', () {
      expect(
        CommandDeskPrefs.orderedSectionIndices(
          categoryTitles: titles,
          lastUsedByCategory: {'Org': 100, 'Invoices': 100},
          sortByRecent: true,
        ),
        [0, 2, 1, 3, 4],
      );
    });
  });

  group('CommandDeskPrefs.sectionLastUsed', () {
    test('parses latest timestamp per category, ignores junk', () {
      const entries = [
        'Invoices::Add::100',
        'Intel::Predict::300',
        'Invoices::List::250',
        'garbage',
        'Invoices::Broken::notanum',
        'Other::X::999',
      ];
      expect(CommandDeskPrefs.sectionLastUsed('Invoices', entries), 250);
      expect(CommandDeskPrefs.sectionLastUsed('Intel', entries), 300);
      expect(CommandDeskPrefs.sectionLastUsed('Training', entries), isNull);
    });
  });

  group('CommandDeskPrefs persistence', () {
    tearDown(() {
      // Static notifier leaks across tests in one run — restore default.
      CommandDeskPrefs.sortByRecent.value = false;
    });

    test('toggle round-trips, recents cap and dedupe', () async {
      SharedPreferences.setMockInitialValues({});
      expect(CommandDeskPrefs.sortByRecent.value, isFalse);

      await CommandDeskPrefs.load();
      expect(CommandDeskPrefs.sortByRecent.value, isFalse);

      await CommandDeskPrefs.setSortByRecent(true);
      expect(CommandDeskPrefs.sortByRecent.value, isTrue);

      await CommandDeskPrefs.recordActionUse(
        'Invoices',
        'Add',
        timestampMillis: 100,
      );
      await CommandDeskPrefs.recordActionUse(
        'Invoices',
        'Add',
        timestampMillis: 200,
      );
      await CommandDeskPrefs.recordActionUse(
        'Intel',
        'Predict',
        timestampMillis: 150,
      );

      final stored = (await SharedPreferences.getInstance()).getStringList(
        CommandDeskPrefs.recentActionsKey,
      );
      // Dedupe: only the newest Add tap survives; order follows tap
      // recency (Predict was tapped last).
      expect(stored, ['Intel::Predict::150', 'Invoices::Add::200']);
      expect(CommandDeskPrefs.sectionLastUsed('Invoices', stored!), 200);

      await CommandDeskPrefs.load();
      expect(CommandDeskPrefs.sortByRecent.value, isTrue);
    });
  });
}
