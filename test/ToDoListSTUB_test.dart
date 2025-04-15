import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kenguruu/pages/ToDoListPage.dart';
import 'stubs/StubToDoController.dart';

void main() {
  testWidgets('Rodo stub\'uotas užduotis ekrane', (tester) async {
    final stubController = StubToDoController();

    await tester.pumpWidget(MaterialApp(
      home: ToDoListPage(title: 'Testas', controller: stubController),
    ));

    expect(find.text('Pirmoji užduotis'), findsOneWidget);
    expect(find.text('Antroji užduotis'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Prideda užduotį per dialogą', (tester) async {
    final stub = StubToDoController();

    await tester.pumpWidget(MaterialApp(
      home: ToDoListPage(title: 'Pridėjimo testas', controller: stub),
    ));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Nauja stub užduotis');
    await tester.tap(find.text('Įdėti'));
    await tester.pumpAndSettle();

    expect(find.text('Nauja stub užduotis'), findsOneWidget);
  });

  testWidgets('Ištrina užduotį per popup', (tester) async {
    final stub = StubToDoController();
    stub.addTask('Užduotis trynimui');

    await tester.pumpWidget(MaterialApp(
      home: ToDoListPage(title: 'Trynimo testas', controller: stub),
    ));

    expect(find.text('Užduotis trynimui'), findsOneWidget);

    final moreOptionsButton = find.descendant(
      of: find.widgetWithText(ListTile, 'Užduotis trynimui'),
      matching: find.byIcon(Icons.more_vert),
    );
    await tester.tap(moreOptionsButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ištrinti'));
    await tester.pumpAndSettle();

    expect(find.text('Užduotis trynimui'), findsNothing);
  });

  testWidgets('Redaguoja užduotį per popup', (tester) async {
    final stub = StubToDoController();
    stub.addTask('Redaguojama užduotis');

    await tester.pumpWidget(MaterialApp(
      home: ToDoListPage(title: 'Redagavimo testas', controller: stub),
    ));

    final moreOptionsButton = find.descendant(
      of: find.widgetWithText(ListTile, 'Redaguojama užduotis'),
      matching: find.byIcon(Icons.more_vert),
    );
    await tester.tap(moreOptionsButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Redaguoti'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'Atnaujinta užduotis');
    await tester.tap(find.text('Išsaugoti'));
    await tester.pumpAndSettle();

    expect(find.text('Atnaujinta užduotis'), findsOneWidget);
  });

  testWidgets('Atlieka checkbox toggle veiksmą', (tester) async {
    final stub = StubToDoController();
    stub.addTask('Toggle užduotis');

    await tester.pumpWidget(MaterialApp(
      home: ToDoListPage(title: 'Checkbox testas', controller: stub),
    ));

    final checkbox = find.byType(Checkbox).last;
    final initialValue = stub.toDoList.last[1];

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(stub.toDoList.last[1], equals(!initialValue));
  });
}