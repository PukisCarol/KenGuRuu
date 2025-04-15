//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'ToDoPageButton.dart';
import 'ToDoPageBox.dart';
import '../logic/ToDoListLogic.dart';

class ToDoListPage extends StatefulWidget {
  final String title;
  final ToDoController? controller; // <-- naujas parametras testavimui

  const ToDoListPage({
    super.key,
    required this.title,
    this.controller, // <-- leidžia naudoti stub testuose
  });

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final _controller = TextEditingController();
  late final ToDoController toDoController;

  @override
  void initState() {
    super.initState();
    toDoController = widget.controller ?? ToDoController(); // naudok stub jei paduotas
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoController.toggleTaskCompletion(index);
    });
  }

  void saveNewTask() {
    setState(() {
      toDoController.addTask(_controller.text);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      toDoController.deleteTask(index);
    });
  }

  void editTask(int index) {
    String currentTaskName = toDoController.toDoList[index][0];
    TextEditingController _controllerNew = TextEditingController(text: currentTaskName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Redaguoti užduotį'),
          content: TextField(
            controller: _controllerNew,
            decoration: InputDecoration(hintText: 'Įrašyti naują užduotį'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Atšaukti'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  toDoController.editTask(index, _controllerNew.text);
                  _controllerNew.clear();
                });
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
      // Gradient background for the entire page
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
              // Title
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
              // Task list
              Expanded(
                child: ListView.builder(
                  itemCount: toDoController.toDoList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            child: MyTextBox(
                              taskName: toDoController.toDoList[index][0],
                              taskCompleted: toDoController.toDoList[index][1],
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
      // Transparent floating action button
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.white.withOpacity(0.2), // Permatomas fonas
          child: Icon(Icons.add, color: Colors.blue),
          elevation: 0, // Pašalinti šešėlį, jei nenori
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Apvalūs kampai
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}