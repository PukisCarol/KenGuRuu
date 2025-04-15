import 'package:flutter_test/flutter_test.dart';
import '../lib/logic/ToDoListLogic.dart';

void main() {
  group('ToDoController', () {
    late ToDoController controller;

    setUp(() {
      controller = ToDoController();
    });

    test('should add a new task', () {
      print('Before adding: ${controller.toDoList}');
      controller.addTask('Test Task');
      print('After adding: ${controller.toDoList}');
      expect(controller.toDoList.length, 1);
      expect(controller.toDoList[0], ['Test Task', false]);
    });

    test('should delete a task', () {
      controller.addTask('Task to Delete');
      print('Before deletion: ${controller.toDoList}');
      controller.deleteTask(0);
      print('After deletion: ${controller.toDoList}');
      expect(controller.toDoList.length, 0);
    });

    test('should toggle task completion', () {
      controller.addTask('Toggle Task');
      print('Before completion: ${controller.toDoList}');
      controller.toggleTaskCompletion(0);
      print('After completion: ${controller.toDoList}');
      expect(controller.toDoList[0][1], true);
    });

    test('should edit a task name', () {
      controller.addTask('Old Name');
      print('Before editing: ${controller.toDoList}');
      controller.editTask(0, 'New Name');
      print('After editing: ${controller.toDoList}');
      expect(controller.toDoList[0][0], 'New Name');
    });
  });
}