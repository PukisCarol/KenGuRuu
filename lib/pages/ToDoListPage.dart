//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';
import 'ToDoPageButton.dart';
import 'ToDoPageBox.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key, required this.title});

  final String title;

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {

  final _controller = TextEditingController();

 List toDoList = [
   //["Pirma užduotis", false],
   //["Antra užduotis", false],
 ];

 // checkbox was tapped
 void checkBoxChanged(bool? value, int index) {
   setState(() {
     toDoList[index][1] =  !toDoList[index][1];
   });
 }

 //Ideti new task
  void saveNewTask() {
   setState(() {
     toDoList.add([_controller.text, false]);
     _controller.clear();
   });
   Navigator.of(context).pop();
  }
  
  void deleteTask(int index) {
   setState(() {
     toDoList.removeAt(index);
   });
  }

  void editTask(int index) {
    String currentTaskName = toDoList[index][0];
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
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Atšaukti'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Find task and update
                  toDoList[index][0] = _controllerNew.text;
                  _controllerNew.clear();
                });
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Išsaugoti'),
            ),
          ],
        );
      },
    );
  }

 // create a new task
 void createNewTask() {
   showDialog(
       context: context,
       builder: (context) {
     return ButtonDialog(
       controller: _controller,
       onSave: saveNewTask,
       onCancel: () => Navigator.of(context).pop(),
     );
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Užduočių sąrašas'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return MyTextBox(
              taskName: toDoList[index][0],
              taskCompleted: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              onDelete: (context) => deleteTask(index),
              onEdit: (context) => editTask(index),
              index: index,
          );
        }
      ),
    );
  }
}