import 'package:mobx/mobx.dart';
import '../entity/todolist_task.dart';
import '../entity/todolist_task_repository.dart';

part 'todolist_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  final TaskRepository repository;

  _TodoStore(this.repository) {
    loadTasks();
  }

  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  double get completionPercentage {
    if (tasks.isEmpty) return 0;
    final completed = tasks.where((t) => t.completed).length;
    return completed / tasks.length * 100;
  }

  @action
  void loadTasks() {
    isLoading = true;
    repository.watchTasks().listen(
          (data) {
        tasks = ObservableList.of(
          data..sort((a, b) => a.completed == b.completed ? 0 : a.completed ? 1 : -1),
        );
        isLoading = false;
      },
      onError: (e) {
        errorMessage = e.toString();
        isLoading = false;
      },
    );
  }

  @action
  Future<void> addTask(String title) => repository.addTask(title);

  @action
  Future<void> toggleCompleted(Task task, bool value) =>
      repository.toggleCompleted(task.id, value);

  @action
  Future<void> deleteTask(String id) => repository.deleteTask(id);

  @action
  Future<void> updateTask(Task task) =>
      repository.updateTask(task);
}