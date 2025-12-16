import 'todolist_task.dart';
abstract class TaskRepository {
  Stream<List<Task>> watchTasks();
  Future<void> addTask(String title);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> toggleCompleted(String id, bool completed);
}