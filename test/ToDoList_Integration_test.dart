import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kenguruu/MyApp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kenguruu/firebase_options.dart'; // <- If you used flutterfire CLI
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kenguruu/NavigationBar.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("full flow - ToDo and Diary page test", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NavigationBarApp(title: 'Navigacija'),
    ));
    await tester.pumpAndSettle();

    // ======== ToDoListPage Tests ========

    // Add a task
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Integration Task');
    await tester.tap(find.text('Įdėti'));
    await tester.pumpAndSettle();
    expect(find.text('Integration Task'), findsOneWidget);

    // Check the task
    Finder checkBox = find.byType(Checkbox).first;
    await tester.tap(checkBox);
    await tester.pumpAndSettle();

    Checkbox cbWidget = tester.widget(checkBox);
    expect(cbWidget.value, true);

    // Uncheck it again
    await tester.tap(checkBox);
    await tester.pumpAndSettle();
    cbWidget = tester.widget(checkBox);
    expect(cbWidget.value, false);

    // Edit the task
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Redaguoti'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Updated Task');
    await tester.tap(find.text('Išsaugoti'));
    await tester.pumpAndSettle();
    expect(find.text('Updated Task'), findsOneWidget);

    // Delete the task
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ištrinti'));
    await tester.pumpAndSettle();
    expect(find.text('Updated Task'), findsNothing);

    // ======== DiaryPage Tests ========

    // Navigate to DiaryPage (index 1 in the bottom navigation bar)
    await tester.tap(find.byIcon(Icons.home).at(1)); // Index 1 = Diary
    await tester.pumpAndSettle();

    // Enter text into the diary input
    String diaryText = 'My diary entry for testing';
    await tester.enterText(find.byType(TextField), diaryText);
    await tester.pumpAndSettle();
    expect(find.text(diaryText), findsOneWidget);

    // Press delete (eraser) button
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(find.text(diaryText), findsNothing); // Expect it to be cleared
  });
}