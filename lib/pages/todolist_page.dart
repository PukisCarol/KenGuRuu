import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'todolist_store.dart';
import '../entity/todolist_task.dart';
import 'ToDoPageBox.dart';
import 'ToDoPageButton.dart';

class todolist_page extends StatelessWidget {
  final TodoStore store;
  final TextEditingController controller = TextEditingController();

  todolist_page({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewTask(context),
        child: const Icon(Icons.add),
      ),
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.errorMessage != null) {
            return Center(child: Text(store.errorMessage!));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: store.tasks.length,
                  itemBuilder: (_, index) {
                    final task = store.tasks[index];

                    return MyTextBox(
                      taskName: task.title,
                      taskCompleted: task.completed,
                      onChanged: (v) =>
                          store.toggleCompleted(task, v ?? false),
                      onDelete: (_) => store.deleteTask(task.id),
                      onEdit: (_) => _editTask(context, task),
                      index: index,
                    );
                  },
                ),
              ),
              Text('${store.completionPercentage.toStringAsFixed(0)}%'),
            ],
          );
        },
      ),
    );
  }

  void _createNewTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ButtonDialog(
        controller: controller,
        onSave: () {
          if (controller.text.trim().isEmpty) return;
          store.addTask(controller.text.trim());
          controller.clear();
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void _editTask(BuildContext context, Task task) {
    final editController = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit task'),
        content: TextField(controller: editController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              store.updateTask(
                Task(
                  id: task.id,
                  title: editController.text,
                  completed: task.completed,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}