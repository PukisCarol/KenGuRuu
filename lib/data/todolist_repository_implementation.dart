import '../entity/todolist_task.dart';
import '../entity/todolist_task_repository.dart';
import '../../services/firestore_services.dart';
import 'todolist_model.dart';

class TodoRepositoryImpl implements TaskRepository {
  final FirestoreService firestore;

  TodoRepositoryImpl(this.firestore);

  @override
  Stream<List<Task>> watchTasks() {
    return firestore.getTasks().map(
          (data) => data.map((e) => TaskModel.fromMap(e)).toList(),
    );
  }

  @override
  Future<void> addTask(String title) {
    final task = TaskModel(
      id: '',
      title: title,
      completed: false,
    );

    return firestore.addTask(task.toMap());
  }

  @override
  Future<void> updateTask(Task task) {
    return firestore.updateTask(
      task.id,
      TaskModel(
        id: task.id,
        title: task.title,
        completed: task.completed,
      ).toMap(),
    );
  }

  @override
  Future<void> toggleCompleted(String id, bool completed) {
    return firestore.updateTask(id, {
      'completed': completed,
    });
  }

  @override
  Future<void> deleteTask(String id) {
    return firestore.deleteTask(id);
  }
}
