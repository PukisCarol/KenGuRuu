import 'package:flutter_test/flutter_test.dart';
import 'package:kenguruu/logic/ToDoListLogic.dart';

void main() {
  group('ToDoController', () {
    late ToDoController controller;

    setUp(() {
      controller = ToDoController();
    });

    test('should add a new task', () {
      final tasks = [ 'kazkas', 'kazkas dar', 'blabla'];
      for(int i = 0; i < tasks.length; i++) {
        controller.addTask(tasks[i]);
        expect(controller.toDoList.length, i+1);
        expect(controller.toDoList[i], [tasks[i], false]);
      }
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