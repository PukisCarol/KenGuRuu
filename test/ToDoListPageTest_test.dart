import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kenguruu/pages/ToDoListPage.dart';
import 'stubs/StubToDoController.dart';

void main() {
  testWidgets('Rodo stub\'uotas užduotis ekrane', (WidgetTester tester) async {
    final stubController = StubToDoController();

    await tester.pumpWidget(MaterialApp(
      home: ToDoListPage(title: 'Testas', controller: stubController),
    ));

    // Tikrina, ar abi stub’uotos užduotys yra matomos
    expect(find.text('Pirmoji užduotis'), findsOneWidget);
    expect(find.text('Antroji užduotis'), findsOneWidget);

    // Tikrina, ar yra mygtukas naujai užduočiai sukurti
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}