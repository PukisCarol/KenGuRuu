
import 'package:flutter/material.dart';
import '../MyApp.dart';
import 'ToDoPageDialogButtons.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key, required this.title});

  final String title;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Dienoraštis"),
        elevation: 0,
      ),
        body: TextField(
          minLines: null,
          maxLines: null,
          expands: true,
          maxLength: TextField.noMaxLength,
        ),
    );
  }
}