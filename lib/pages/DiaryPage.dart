
import 'package:flutter/material.dart';
import 'package:kenguruu/pages/ToDoPageDialogButtons.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key, required this.title});
  final String title;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  List<String> diaryEntries = [];

  void clearTextField() {
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // "Diary" title aligned to the right
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Diary',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[400],
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Pink diary input box with rounded corners and shadow
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _controller,
                    minLines: null,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Your text',
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Eraser button
      floatingActionButton: FloatingActionButton(
        onPressed: clearTextField,
        backgroundColor: Colors.pink,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}