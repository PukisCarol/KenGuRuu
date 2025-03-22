
import 'package:flutter/material.dart';
import 'package:kenguruu/pages/ToDoPageDialogButtons.dart';

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
    if(_controller.text.trim().isEmpty) {
      showDialog(
        context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Colors.blue,
                content: SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Nieko neįrašėte'),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MyButton(text: 'Gerai', onPressed: Navigator.of(context).pop)
                            ],
                        ),
                      ],
                    ),
                ),
            );
          },
      );
    } else {
      setState(() {
        diaryEntries.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Dienoraštis"),
        elevation: 0,
      ),
        body: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: null,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Rašykite savo mintis čia...',
                  contentPadding: EdgeInsets.all(26),
                  border: InputBorder.none,
                ),
              ),
            ),
            if(diaryEntries.isNotEmpty)
              Container(
                color:Colors.white,
                height: 200,
                child: ListView.builder(
                  itemCount: diaryEntries.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(diaryEntries[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveDiary,
        child: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}