import 'package:kenguruu/logic/ToDoListLogic.dart';

class StubToDoController extends ToDoController {
  final List<List<dynamic>> _stubList = [];

  StubToDoController() {
    addTask('Pirmoji užduotis');
    addTask('Antroji užduotis');
    toggleTaskCompletion(1); // pažymim antrą užduotį kaip atliktą
  }

  @override
  List get toDoList => _stubList;

  @override
  void addTask(String taskName) {
    _stubList.add([taskName, false]);
  }

  @override
  void deleteTask(int index) {
    _stubList.removeAt(index);
  }

  @override
  void editTask(int index, String newTaskName) {
    _stubList[index][0] = newTaskName;
  }

  @override
  void toggleTaskCompletion(int index) {
    _stubList[index][1] = !_stubList[index][1];
  }
}