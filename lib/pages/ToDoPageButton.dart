import 'package:flutter/material.dart';
import 'package:kenguruu/pages/ToDoPageDialogButtons.dart';

class ButtonDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ButtonDialog({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlueAccent,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Pridėti užduotį...",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  key: Key('save_button'), // Pridėtas Key
                  text: "Įdėti",
                  onPressed: onSave,
                ),
                const SizedBox(width: 8),
                MyButton(
                  key: Key(' cancel_button'), // Pridėtas Key
                  text: "Atšaukti",
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}