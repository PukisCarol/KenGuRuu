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
    return firestore.addTask(title);
  }

  @override
  Future<void> updateTask(Task task) {
    return firestore.updateTask(task.id, task.title);
  }

  @override
  Future<void> toggleCompleted(String id, bool completed) {
    return firestore.toggleTaskCompleted(id, completed);
  }

  @override
  Future<void> deleteTask(String id) {
    return firestore.deleteTask(id);
  }
}
