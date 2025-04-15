import 'dart:ui';
import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onDelete;
  final Function(BuildContext)? onEdit;
  final int index;

  const MyTextBox({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          leading: Checkbox(
            value: taskCompleted,
            onChanged: onChanged,
            activeColor: Colors.blueAccent,
          ),
          title: Text(
            taskName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              decoration: taskCompleted ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: PopupMenuButton<String>(
            key: Key('popup_menu_$index'), // Pridėtas Key
            onSelected: (value) {
              if (value == 'edit') onEdit?.call(context);
              if (value == 'delete') onDelete?.call(context);
            },
            icon: Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'edit',
                child: Text('Redaguoti'),
                key: Key('edit_menu_item_$index'), // Pridėtas Key
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text('Ištrinti'),
                key: Key('delete_menu_item_$index'), // Pridėtas Key
              ),
            ],
          ),
        ),
      ),
    );
  }
}