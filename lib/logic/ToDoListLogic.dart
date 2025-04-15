class ToDoController {
  List toDoList = [];

  void addTask(String taskName) {
    toDoList.add([taskName, false]);
  }

  void deleteTask(int index) {
    toDoList.removeAt(index);
  }

  void toggleTaskCompletion(int index) {
    toDoList[index][1] = !toDoList[index][1];
  }

  void editTask(int index, String newTaskName) {
    toDoList[index][0] = newTaskName;
  }
}