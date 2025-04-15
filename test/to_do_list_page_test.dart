import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:kenguruu/pages/ToDoListPage.dart';
import 'mocks/mocks.mocks.dart'; // Sugeneruotas mock failas

void main() {
  late MockToDoController mockToDoController;

  setUp(() {
    mockToDoController = MockToDoController();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ToDoListPage(
        title: 'To Do List',
        controller: mockToDoController,
      ),
    );
  }

  testWidgets('Rodo tuščią sąrašą, kai toDoList yra tuščias', (WidgetTester tester) async {
    when(mockToDoController.toDoList).thenReturn([]);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('To do list'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Rodo užduotis, kai toDoList turi elementų', (WidgetTester tester) async {
    when(mockToDoController.toDoList).thenReturn([
      ['Pirkti pieną', false],
      ['Išvalyti kambarį', true],
    ]);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Pirkti pieną'), findsOneWidget);
    expect(find.text('Išvalyti kambarį'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('Kviečia addTask, kai pridedama nauja užduotis', (WidgetTester tester) async {
    when(mockToDoController.toDoList).thenReturn([]);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Spaudžiame FAB mygtuką
    await tester.tap(find.byKey(Key('add_task_button')));
    await tester.pumpAndSettle();

    // Įvedame tekstą
    await tester.enterText(find.byType(TextField), 'Nauja užduotis');
    // Spaudžiame "Įdėti" mygtuką
    await tester.tap(find.byKey(Key('save_button')));
    await tester.pumpAndSettle();

    // Tikriname, ar addTask buvo iškviestas
    verify(mockToDoController.addTask('Nauja užduotis')).called(1);
  });

  testWidgets('Kviečia deleteTask, kai užduotis pašalinama', (WidgetTester tester) async {
    when(mockToDoController.toDoList).thenReturn([
      ['Pirkti pieną', false],
    ]);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Spaudžiame PopupMenu mygtuką
    await tester.tap(find.byKey(Key('popup_menu_0')));
    await tester.pumpAndSettle();

    // Pasirenkame "Ištrinti" meniu punktą
    await tester.tap(find.byKey(Key('delete_menu_item_0')));
    await tester.pumpAndSettle();

    // Tikriname, ar deleteTask buvo iškviestas
    verify(mockToDoController.deleteTask(0)).called(1);
  });

  testWidgets('Kviečia editTask, kai užduotis redaguojama', (WidgetTester tester) async {
    when(mockToDoController.toDoList).thenReturn([
      ['Pirkti pieną', false],
    ]);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Spaudžiame PopupMenu mygtuką
    await tester.tap(find.byKey(Key('popup_menu_0')));
    await tester.pumpAndSettle();

    // Pasirenkame "Redaguoti" meniu punktą
    await tester.tap(find.byKey(Key('edit_menu_item_0')));
    await tester.pumpAndSettle();

    // Įvedame naują tekstą
    await tester.enterText(find.byType(TextField), 'Pirkti duoną');
    // Spaudžiame "Išsaugoti" mygtuką
    await tester.tap(find.byKey(Key('save_edit_button')));
    await tester.pumpAndSettle();

    // Tikriname, ar editTask buvo iškviestas
    verify(mockToDoController.editTask(0, 'Pirkti duoną')).called(1);
  });
}