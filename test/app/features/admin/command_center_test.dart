import 'package:carenest/app/features/admin/utils/command_desk_prefs.dart';
import 'package:carenest/app/features/admin/widgets/bauhaus_command_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

List<CommandCategory> testCategories({void Function(String)? onTap}) {
  CommandAction action(String title) => CommandAction(
    icon: const Icon(Icons.star_outline_rounded),
    title: title,
    subtitle: 'Do $title',
    color: Colors.red,
    onTap: () => onTap?.call(title),
  );
  return [
    CommandCategory(
      title: 'Invoices',
      headerIcon: Icons.receipt_long_rounded,
      accentColor: Colors.red,
      actions: [action('Create invoice'), action('List invoices')],
    ),
    CommandCategory(
      title: 'Training',
      headerIcon: Icons.school_rounded,
      accentColor: Colors.blue,
      actions: [action('Review trips')],
    ),
    CommandCategory(
      title: 'Org',
      headerIcon: Icons.business_rounded,
      accentColor: Colors.green,
      actions: [action('Manage org')],
    ),
  ];
}

Future<void> pumpDesk(
  WidgetTester tester,
  List<CommandCategory> categories,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: BauhausCommandCenter(categories: categories),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  tearDown(() {
    CommandDeskPrefs.sortByRecent.value = false;
  });

  testWidgets('renders sections, first expanded', (tester) async {
    await pumpDesk(tester, testCategories());
    expect(find.text('INVOICES'), findsOneWidget);
    expect(find.text('TRAINING'), findsOneWidget);
    expect(find.text('ORG'), findsOneWidget);
    // First section expanded: its actions visible.
    expect(find.text('Create invoice'), findsOneWidget);
    // Collapsed sections hide their actions.
    expect(find.text('Review trips'), findsNothing);
    expect(find.text('Manage org'), findsNothing);
  });

  testWidgets('expanding a section reveals its actions', (tester) async {
    await pumpDesk(tester, testCategories());
    await tester.tap(find.text('TRAINING'));
    await tester.pumpAndSettle();
    expect(find.text('Review trips'), findsOneWidget);
  });

  testWidgets('search filters across categories', (tester) async {
    await pumpDesk(tester, testCategories());
    await tester.enterText(find.byType(TextField), 'manage');
    await tester.pumpAndSettle();
    expect(find.text('Manage org'), findsOneWidget);
    expect(find.text('Create invoice'), findsNothing);
    // Non-matching sections disappear.
    expect(find.text('INVOICES'), findsNothing);
  });

  testWidgets('tapping records recency and floats section when opted in', (
    tester,
  ) async {
    var tapped = '';
    await pumpDesk(tester, testCategories(onTap: (t) => tapped = t));

    // Expand Training and tap its action.
    await tester.tap(find.text('TRAINING'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Review trips'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Review trips'));
    await tester.pumpAndSettle();
    expect(tapped, 'Review trips');

    // Toggle off (default): original order kept.
    var headers = tester
        .widgetList<Text>(
          find.byWidgetPredicate(
            (w) =>
                w is Text && ['INVOICES', 'TRAINING', 'ORG'].contains(w.data),
          ),
        )
        .map((t) => t.data!)
        .toList();
    expect(headers, ['INVOICES', 'TRAINING', 'ORG']);

    // Opt in: Training floats above Invoices with a RECENT chip.
    await CommandDeskPrefs.setSortByRecent(true);
    await tester.pumpAndSettle();
    headers = tester
        .widgetList<Text>(
          find.byWidgetPredicate(
            (w) =>
                w is Text && ['INVOICES', 'TRAINING', 'ORG'].contains(w.data),
          ),
        )
        .map((t) => t.data!)
        .toList();
    expect(headers.first, 'TRAINING');
    expect(find.text('RECENT'), findsOneWidget);
  });
}
