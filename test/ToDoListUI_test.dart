import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kenguruu/pages/ToDoListPage.dart';

void main() {

  testWidgets('adds a new task and displays it', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ToDoListPage(title: 'Test Title'),
      ),
    );
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter text in the dialog's text field
    await tester.enterText(find.byType(TextField), 'No Test Task');

    // Tap the save button
    await tester.tap(find.text('Atšaukti'));
    await tester.pumpAndSettle();

    // Tap the floating action button to open dialog
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter text in the dialog's text field
    await tester.enterText(find.byType(TextField), 'Test Task');

    // Tap the save button
    await tester.tap(find.text('Įdėti'));
    await tester.pumpAndSettle();

    // Verify that the task is now shown
    expect(find.text('Test Task'), findsOneWidget);
  });

  testWidgets('toggles task completion', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: ToDoListPage(title: 'Test'),
        ),
    );
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Toggle Task');
    await tester.tap(find.text('Įdėti'));
    await tester.pumpAndSettle();

    // Find the checkbox and toggle it
    final checkbox = find.byType(Checkbox).first;
    expect(checkbox, findsOneWidget);
    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    // You could assert checkbox state or visual change depending on your design
  });

  testWidgets('deletes a task using the dropdown menu', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: ToDoListPage(title: 'Test'),
        ),
    );

    // Add a task first
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Task to Delete');
    await tester.tap(find.text('Įdėti'));
    await tester.pumpAndSettle();

    expect(find.text('Task to Delete'), findsOneWidget);

    // Tap on the dropdown menu (usually a 3-dot icon or similar)
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();

    // Tap the delete option
    await tester.tap(find.text('Ištrinti'));
    await tester.pumpAndSettle();

    // Check if it's removed
    expect(find.text('Task to Delete'), findsNothing);
  });

  testWidgets('edits a task using the dropdown menu', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: ToDoListPage(title: 'Test'),
        ),
    );

    // Add a task
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Old Task Name');
    await tester.tap(find.text('Įdėti'));
    await tester.pumpAndSettle();

    expect(find.text('Old Task Name'), findsOneWidget);

    // Open dropdown menu
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();

    // Tap the "Edit" option
    await tester.tap(find.text('Redaguoti'));
    await tester.pumpAndSettle();

    // Replace the text
    await tester.enterText(find.byType(TextField), 'Updated Task Name');
    await tester.tap(find.text('Atšaukti'));
    await tester.pumpAndSettle();

    // Open dropdown menu
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();

    // Tap the "Edit" option
    await tester.tap(find.text('Redaguoti'));
    await tester.pumpAndSettle();

    // Replace the text
    await tester.enterText(find.byType(TextField), 'Updated Task Name');
    await tester.tap(find.text('Išsaugoti'));
    await tester.pumpAndSettle();

    expect(find.text('Old Task Name'), findsNothing);
    expect(find.text('Updated Task Name'), findsOneWidget);
  });
}