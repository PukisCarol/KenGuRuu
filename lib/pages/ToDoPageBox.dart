import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  final void Function(int) onDelete;
  final void Function(int) onEdit;
  final int index;

  MyTextBox({
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
        padding: const EdgeInsets.only(left:25.0, right:25.0, top:25.0),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
              ),
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none, color: Colors.white),
                ),
              ),
              PopupMenuButton(
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      value: 'Redaguoti',
                      child: Text('Redaguoti'),
                    ),
                    PopupMenuItem(
                      value: 'Ištrinti',
                      child: Text('Ištrinti'),
                    ),
                  ],
                icon: Icon(Icons.more_vert, color: Colors.white),
                onSelected: (String choice) {
                  if(choice == 'Redaguoti') {
                    onEdit(index);
                  } else if(choice == 'Ištrinti') {
                    onDelete(index);
                  }
                },
              ),
            ],
          ),
        ),
    );
  }
}