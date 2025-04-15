class ToDoController {
  List<List<dynamic>> _toDoList = [];

  List<List<dynamic>> get toDoList => _toDoList;

  set toDoList(List<List<dynamic>> value) {
    _toDoList = value;
  }

  void addTask(String taskName) {
    _toDoList.add([taskName, false]);
  }

  void deleteTask(int index) {
    _toDoList.removeAt(index);
  }

  void toggleTaskCompletion(int index) {
    _toDoList[index][1] = !_toDoList[index][1];
  }

  void editTask(int index, String newTaskName) {
    _toDoList[index][0] = newTaskName;
  }
}