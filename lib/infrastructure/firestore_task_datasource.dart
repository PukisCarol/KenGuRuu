import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_model.dart';

class FirestoreTaskDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<TaskModel>> watchTasks() {
    return firestore.collection('tasks').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => TaskModel.fromFirestore(doc))
          .toList(),
    );
  }

  Future<void> addTask(TaskModel task) async {
    await firestore.collection('tasks').add(task.toJson());
  }

  Future<void> updateTask(TaskModel task) async {
    await firestore.collection('tasks').doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String id) async {
    await firestore.collection('tasks').doc(id).delete();
  }
}