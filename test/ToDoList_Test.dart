import 'package:flutter_test/flutter_test.dart';
import '../lib/logic/ToDoListLogic.dart';

void main() {
  group('ToDoController', () {
    late ToDoController controller;

    setUp(() {
      controller = ToDoController();
    });

    test('should add a new task', () {
      controller.addTask('Test Task');
      expect(controller.toDoList.length, 1);
      expect(controller.toDoList[0], ['Test Task', false]);
    });

    test('should delete a task', () {
      controller.addTask('Task to Delete');
      controller.deleteTask(0);
      expect(controller.toDoList.length, 0);
    });

    test('should toggle task completion', () {
      controller.addTask('Toggle Task');
      controller.toggleTaskCompletion(0);
      expect(controller.toDoList[0][1], true);
    });

    test('should edit a task name', () {
      controller.addTask('Old Name');
      controller.editTask(0, 'New Name');
      expect(controller.toDoList[0][0], 'New Name');
    });
  });
}