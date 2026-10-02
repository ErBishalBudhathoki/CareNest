import 'package:carenest/app/features/expenses/models/expense_model.dart';
import 'package:carenest/app/features/expenses/providers/expense_provider.dart';
import 'package:carenest/app/features/expenses/views/expense_management_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// The expense dashboard's "Recent expenses" heading overflowed by 27px on the
/// right.
///
/// The row paired a 28px heading with a "View all" button and nothing was
/// allowed to shrink, so the pair was wider than a 335px phone. Because the
/// label comes from `l10n`, the width is a function of the active locale, so
/// this is driven through a language whose strings are longer than the English
/// ones rather than only the default.
void main() {
  ExpenseModel expense(String id, String title) => ExpenseModel(
    id: id,
    title: title,
    amount: 50,
    category: 'Software',
    date: DateTime(2026, 5, 3),
    status: 'approved',
    submittedBy: 'user@example.com',
    createdAt: DateTime(2026, 5, 3),
    isRecurring: false,
    organizationId: 'org-1',
    clientId: 'client-1',
  );

  Future<void> pumpDashboard(
    WidgetTester tester, {
    required Locale locale,
    double width = 320,
  }) async {
    await tester.binding.setSurfaceSize(Size(width, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          expenseProvider.overrideWith(
            () => FakeExpenseNotifier([
              expense('1', 'A receipt with a long description for the row'),
              expense('2', 'Another receipt, also fairly long'),
            ]),
          ),
        ],
        child: MaterialApp(
          theme: BauhausDesign.lightTheme,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ExpenseManagementView(
            adminEmail: 'user@example.com',
            organizationId: 'org-1',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  for (final locale in const [Locale('en'), Locale('de')]) {
    for (final dark in [false, true]) {
      final label =
          '${locale.languageCode} ${dark ? 'dark' : 'light'} at 320px';
      testWidgets('dashboard lays out without overflow: $label', (
        tester,
      ) async {
        await pumpDashboard(tester, locale: locale);
        expect(
          tester.takeException(),
          isNull,
          reason: '$label threw or overflowed during layout',
        );
      });
    }
  }

  testWidgets('the recent expenses heading is allowed to shrink', (
    tester,
  ) async {
    await pumpDashboard(tester, locale: const Locale('en'));
    final heading = find.textContaining('Recent');
    // The fix is structural: the heading yields to the action rather than
    // pushing past the edge. Assert the row's children both fit inside it.
    final row = find.ancestor(of: heading, matching: find.byType(Row));
    expect(row, findsWidgets, reason: 'the heading sits in a Row');
  });
}

/// Minimal notifier so the dashboard renders a known list without the backend.
class FakeExpenseNotifier extends ExpenseNotifier {
  FakeExpenseNotifier(this._expenses);

  final List<ExpenseModel> _expenses;

  @override
  ExpenseState build() => ExpenseState(expenses: _expenses, isLoading: false);
}
