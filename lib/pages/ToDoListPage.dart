import 'dart:ui';
import 'package:flutter/material.dart';
import 'ToDoPageButton.dart';
import 'ToDoPageBox.dart';
import '../logic/ToDoListLogic.dart';
import '../Services/firestore_services.dart';

class ToDoListPage extends StatefulWidget {
  final String title;
  final ToDoController? controller;

  const ToDoListPage({
    super.key,
    required this.title,
    this.controller,
  });

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final _controller = TextEditingController();
  late final ToDoController toDoController;
  final firestore = FirestoreService();
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    firestore.getTasks().listen((loadedTasks) {
      setState(() {
        tasks = sortTasks(loadedTasks);
      });
    });
  }

  List<Map<String, dynamic>> sortTasks(List<Map<String, dynamic>> taskList) {
    // Sort tasks: incomplete first, then completed
    taskList.sort((a, b) {
      if (a['completed'] == b['completed']) return 0;
      return a['completed'] ? 1 : -1;
    });
    return taskList;
  }

  void checkBoxChanged(bool? value, int index) async {
    await firestore.toggleTaskCompleted(tasks[index]['id'], value ?? false);
    setState(() {
      tasks = sortTasks(tasks);
    });
  }

  void saveNewTask() async {
    if (_controller.text.trim().isEmpty) return;
    await firestore.addTask(_controller.text);
    _controller.clear();
    Navigator.of(context).pop();
  }

  void deleteTask(int index) async {
    await firestore.deleteTask(tasks[index]['id']);
  }

  void editTask(int index) {
    TextEditingController editController =
    TextEditingController(text: tasks[index]['task']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Redaguoti užduotį'),
          content: TextField(controller: editController),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Atšaukti'),
            ),
            TextButton(
              onPressed: () async {
                await firestore.updateTask(tasks[index]['id'], editController.text);
                Navigator.of(context).pop();
              },
              child: Text('Išsaugoti'),
            ),
          ],
        );
      },
    );
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return ButtonDialog(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          key: const Key('add_task_button'),
          onPressed: createNewTask,
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.add, color: Colors.blue),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'To do list',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            child: MyTextBox(
                              taskName: tasks[index]['task'],
                              taskCompleted: tasks[index]['completed'],
                              onChanged: (value) => checkBoxChanged(value, index),
                              onDelete: (context) => deleteTask(index),
                              onEdit: (context) => editTask(index),
                              index: index,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}