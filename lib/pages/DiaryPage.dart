
import 'package:flutter/material.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key, required this.title});

  final String title;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final _controller = TextEditingController();

  List diaryEntries = [

  ];

  void saveDiary() {
    setState(() {
      diaryEntries.add(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Dienoraštis"),
        elevation: 0,
      ),
        body: TextField(
          controller: _controller,
          minLines: null,
          maxLines: null,
          expands: true,
          //maxLength: TextField.noMaxLength,
        ),
      bottomSheet: Container(
        child: ElevatedButton(
            onPressed: saveDiary,
            child: Text('Išsaugoti', textAlign: TextAlign.right)),
      ),
    );
  }
}