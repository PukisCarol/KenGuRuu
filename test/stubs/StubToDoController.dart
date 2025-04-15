import 'package:kenguruu/logic/ToDoListLogic.dart';

class StubToDoController implements ToDoController {
  List<List<dynamic>> _stubTasks = [
    ['Pirmoji užduotis', false],
    ['Antroji užduotis', true],
  ];

  @override
  List<List<dynamic>> get toDoList => _stubTasks;

  @override
  set toDoList(List<List<dynamic>> value) {
    _stubTasks = value;
  }

  @override
  void toggleTaskCompletion(int index) {
    _stubTasks[index][1] = !_stubTasks[index][1];
  }

  @override
  void addTask(String taskName) {
    _stubTasks.add([taskName, false]);
  }

  @override
  void deleteTask(int index) {
    _stubTasks.removeAt(index);
  }

  @override
  void editTask(int index, String newName) {
    _stubTasks[index][0] = newName;
  }
}
