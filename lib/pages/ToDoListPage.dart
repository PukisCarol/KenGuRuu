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
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      firestore.getTasks().listen((loadedTasks) {
        setState(() {
          tasks = sortTasks(loadedTasks);
          isLoading = false;
        });
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load tasks: $e';
      });
      _showErrorSnackBar('Failed to load tasks');
    }
  }

  List<Map<String, dynamic>> sortTasks(List<Map<String, dynamic>> taskList) {
    taskList.sort((a, b) {
      if (a['completed'] == b['completed']) return 0;
      return a['completed'] ? 1 : -1;
    });
    return taskList;
  }

  double calculateCompletionPercentage() {
    if (tasks.isEmpty) return 0.0;
    final completedTasks = tasks.where((task) => task['completed']).length;
    return (completedTasks / tasks.length) * 100;
  }

  void checkBoxChanged(bool? value, int index) async {
    try {
      await firestore.toggleTaskCompleted(tasks[index]['id'], value ?? false);
      setState(() {
        tasks = sortTasks(tasks);
      });
    } catch (e) {
      _showErrorSnackBar('Failed to update task status');
    }
  }

  void saveNewTask() async {
    if (_controller.text.trim().isEmpty) return;
    try {
      await firestore.addTask(_controller.text);
      _controller.clear();
      Navigator.of(context).pop();
    } catch (e) {
      _showErrorSnackBar('Failed to add task');
    }
  }

  void deleteTask(int index) async {
    try {
      await firestore.deleteTask(tasks[index]['id']);
    } catch (e) {
      _showErrorSnackBar('Failed to delete task');
    }
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
                try {
                  await firestore.updateTask(tasks[index]['id'], editController.text);
                  Navigator.of(context).pop();
                } catch (e) {
                  _showErrorSnackBar('Failed to update task');
                }
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _refreshTasks() async {
    await _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final double completionPercentage = calculateCompletionPercentage();

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
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : errorMessage != null
                    ? Center(child: Text(errorMessage!))
                    : RefreshIndicator(
                  onRefresh: _refreshTasks,
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Semantics(
                  label: 'Task completion progress: ${completionPercentage.toStringAsFixed(0)} percent',
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: completionPercentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${completionPercentage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}