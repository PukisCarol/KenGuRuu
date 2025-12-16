import '../entity/todolist_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String task;
  final bool completed;

  TaskModel({
    required this.id,
    required this.task,
    required this.completed,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      task: data['task'] ?? '',
      completed: data['completed'] ?? false,
    );
  }

  Task toEntity() => Task(
    id: id,
    title: task,
    completed: completed,
  );

  Map<String, dynamic> toJson() => {
    'task': task,
    'completed': completed,
  };
}