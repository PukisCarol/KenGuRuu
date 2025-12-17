import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addTask(Map<String, dynamic> data) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .add({
      ...data,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteTask(String id) async {
    await _db.collection('users').doc(userId).collection('tasks').doc(id).delete();
  }

  Future<void> updateTask(String id, Map<String, dynamic> data) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(id)
        .update(data);
  }

  Stream<List<Map<String, dynamic>>> getTasks() {
    return _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            ...data,
          };
        }).toList());
  }


  Future<void> addTaskOld(String taskName, {bool completed = false}) async {
    await _db.collection('users').doc(userId).collection('tasks').add({
      'task': taskName,
      'completed': completed,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteTaskOld(String docId) async {
    await _db.collection('users').doc(userId).collection('tasks').doc(docId).delete();
  }

  Future<void> updateTaskOld(String docId, String newTask) async {
    await _db.collection('users').doc(userId).collection('tasks').doc(docId).update({
      'task': newTask,
    });
  }

  Future<void> toggleTaskCompletedOld(String docId, bool completed) async {
    await _db.collection('users').doc(userId).collection('tasks').doc(docId).update({
      'completed': completed,
    });
  }

  Stream<List<Map<String, dynamic>>> getTasksOld() {
    return _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => {
      'id': doc.id,
      'task': doc['task'],
      'completed': doc['completed'],
    })
        .toList());
  }

  Future<String?> getUsername() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.data()?['username'];
  }

  Future<DocumentReference> addCalendarEvent(DateTime date, String title, String description) {
    return _db.collection('users').doc(userId).collection('calendar_events').add({
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'userId': userId, // Add userId field
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteCalendarEvent(String eventId) async {
    await _db.collection('users').doc(userId).collection('calendar_events').doc(eventId).delete();
  }

  Future<void> updateCalendarEvent(String eventId, String title, String description) async {
    await _db.collection('users').doc(userId).collection('calendar_events').doc(eventId).update({
      'title': title,
      'description': description,
    });
  }

  Future<List<Map<String, dynamic>>> fetchCalendarEvents() async {
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('calendar_events')
        .orderBy('date')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'title': data['title'],
        'description': data['description'],
        'date': (data['date'] as Timestamp).toDate(),
      };
    }).toList();
  }
  Stream<List<Map<String, dynamic>>> getCalendarEvents() {
    return _db
        .collection('users')
        .doc(userId)
        .collection('calendar_events')
        .orderBy('date')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            'title': data['title'],
            'description': data['description'],
            'date': (data['date'] as Timestamp).toDate(),
          };
        }).toList());
  }
}