import 'package:flutter/material.dart';
import '../MyApp.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key, required this.title});

  final String title;

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late TextEditingController controller;
  String task = '';

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Užduočių sąrašas"),
      centerTitle: true,
    ),
    body: Container(
      padding: EdgeInsets.all(32),
      child: Column (
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Uzduotys: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Text(task),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: Text('Pridėti užduotį'),
            onPressed: () async {
              final task = await openDialog();
              if(task == null || task.isEmpty) return;

              setState(() => this.task = task);
            },
          ),
        ],
      )
    )
  );

  Future<String?> openDialog() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Uzduotis:'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: 'Irasykite uzduoti'),
        controller: controller,
      ),
        actions: [
          TextButton(
            onPressed: submit,
            child: Text('Prideti'),
          ),
        ]
    ),
  );

  void submit() {
    Navigator.of(context).pop(controller.text);
  }

}