import 'package:carenest/app/features/notes/widgets/structured_note_composer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase 2: the structured progress-note composer renders template sections and
/// collects their values into the map handed to onSubmit.
void main() {
  final template = <String, dynamic>{
    'id': 't1',
    'name': 'Daily shift note',
    'sections': [
      {
        'key': 'summary',
        'label': 'Summary',
        'type': 'longText',
        'required': true,
        'order': 1,
      },
      {
        'key': 'mood',
        'label': 'Mood',
        'type': 'select',
        'options': ['good', 'bad'],
        'order': 2,
      },
      {
        'key': 'medication_given',
        'label': 'Medication given',
        'type': 'checkbox',
        'order': 3,
      },
      {
        'key': 'hours',
        'label': 'Hours',
        'type': 'number',
        'order': 4,
      },
    ],
  };

  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('renders all sections and collects entered values', (tester) async {
    Map<String, dynamic>? submitted;

    await tester.pumpWidget(
      wrap(
        StructuredNoteComposer(
          template: template,
          onSubmit: (data) async => submitted = data,
        ),
      ),
    );
    await tester.pump();

    // Enter a summary and hours.
    await tester.enterText(
      find.widgetWithText(TextField, 'Summary *'),
      'Client was calm',
    );
    await tester.enterText(find.widgetWithText(TextField, 'Hours'), '2.5');

    // Tick the checkbox.
    await tester.tap(find.text('Medication given'));
    await tester.pump();

    // Select a mood.
    await tester.tap(find.text('Mood'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('good').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save note'));
    await tester.pump();

    expect(submitted, isNotNull);
    expect(submitted!['summary'], 'Client was calm');
    expect(submitted!['hours'], 2.5);
    expect(submitted!['medication_given'], true);
    expect(submitted!['mood'], 'good');
  });

  testWidgets('blocks submit when a required section is empty', (tester) async {
    var called = false;
    await tester.pumpWidget(
      wrap(
        StructuredNoteComposer(
          template: template,
          onSubmit: (data) async => called = true,
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Save note'));
    await tester.pump();

    expect(called, isFalse);
    expect(find.text('This field is required'), findsOneWidget);
  });
}
