import '../entity/todolist_task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    required super.title,
    required super.completed,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['task'],
      completed: map['completed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task': title,
      'completed': completed,
    };
  }
}