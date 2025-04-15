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

void main() {

  testWidgets("full flow - add check and uncheck edit delete", (WidgetTester tester) async {

    await tester.pumpWidget(MyApp()); // Replace with your actual app widget
    await tester.pumpAndSettle();

    // Add a task
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Integration Task');
    await tester.tap(find.text('Įdėti'));
    await tester.pumpAndSettle();
    expect(find.text('Integration Task'), findsOneWidget);

    // Find the checkbox and tap to mark complete
    Finder checkBox = find.byType(Checkbox).first;
    await tester.tap(checkBox);
    await tester.pumpAndSettle();

    // Optionally, verify checkbox state is true
    Checkbox cbWidget = tester.widget(checkBox);
    expect(cbWidget.value, true);

    // Uncheck it again
    await tester.tap(checkBox);
    await tester.pumpAndSettle();
    cbWidget = tester.widget(checkBox);
    expect(cbWidget.value, false);

    // Tap edit (using text "Redaguoti" from dropdown if applicable)
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Redaguoti'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Updated Task');
    await tester.tap(find.text('Išsaugoti'));
    await tester.pumpAndSettle();
    expect(find.text('Updated Task'), findsOneWidget);

    // Delete the task (using dropdown "Ištrinti")
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ištrinti'));
    await tester.pumpAndSettle();
    expect(find.text('Updated Task'), findsNothing);
  });
}