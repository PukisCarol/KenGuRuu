import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key, required this.title});
  final String title;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDiary();
  }

  Future<void> loadDiary() async {
    if (user == null) return;

    final doc = await FirebaseFirestore.instance.collection('diaries').doc(user!.uid).get();
    if (doc.exists) {
      setState(() {
        _controller.text = doc['text'] ?? '';
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> saveDiary() async {
    if (user == null) return;

    await FirebaseFirestore.instance.collection('diaries').doc(user!.uid).set({
      'text': _controller.text,
      'updated_at': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Diary saved")),
    );
  }

  Future<void> clearDiary() async {
    setState(() {
      _controller.clear();
    });

    if (user != null) {
      await FirebaseFirestore.instance.collection('diaries').doc(user!.uid).set({
        'text': '',
        'updated_at': FieldValue.serverTimestamp(),
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Diary cleared")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Title
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

            // Text area
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
                        offset: const Offset(0, 6),
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

      // Floating buttons (save + delete)
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Save button (green)
          FloatingActionButton(
            onPressed: saveDiary,
            backgroundColor: Colors.green,
            heroTag: 'save',
            child: const Icon(Icons.save, color: Colors.white),
          ),
          const SizedBox(width: 16),
          // Delete button (red)
          FloatingActionButton(
            onPressed: clearDiary,
            backgroundColor: Colors.pink,
            heroTag: 'delete',
            child: const Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
