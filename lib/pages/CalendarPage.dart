import 'package:flutter/material.dart';
import 'package:kenguruu/pages/ToDoPageDialogButtons.dart';
import 'package:calendar_view/calendar_view.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.title});

  final String title;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  EventController? _controller;

  void _addEvent(DateTime date) {
    showDialog(
      context: context,
      builder: (context) {
        final titleController = TextEditingController();
        final descriptionController = TextEditingController();

        return AlertDialog(
          title: const Text("Pridėti įvykį"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Įvykio pavadinimas"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: "Įvykio aprašymas"),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                final event = CalendarEventData(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: date,
                  event: {
                    'title': titleController.text,
                    'description': descriptionController.text,
                  },
                );

                _controller?.add(event);
              },
              child: const Text("Pridėti"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize controller here instead of initState
    _controller = CalendarControllerProvider
        .of(context)
        .controller;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MonthView(
        controller: _controller!,
        onCellTap: (events, date) {
          _addEvent(date);
        },
        onEventTap: (event, date) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(event.title),
              content: Text(event.description ?? "Nėra aprašymo"), //
              actions: [
                TextButton(
                  child: const Text("Uždaryti"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}