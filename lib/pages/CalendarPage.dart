import 'package:flutter/material.dart';
import 'package:kenguruu/pages/ToDoPageDialogButtons.dart';
//import 'package:calendar_view/calendar_view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  final String title;
  const CalendarPage({super.key, required this.title});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Laikoma Map<Date, List<įvykiai>>
  final Map<DateTime, List<Map<String, String>>> _events = {};

  DateTime _normalize(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  List<Map<String, String>> _eventsForDay(DateTime day) =>
      _events[_normalize(day)] ?? [];

  Future<void> _addEvent(DateTime date) async {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pridėti įvykį"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(hintText: "Pavadinimas"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(hintText: "Aprašymas"),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Atšaukti")),
          TextButton(
            onPressed: () {
              final nd = _normalize(date);
              final newEvent = {
                'title': titleCtrl.text,
                'description': descCtrl.text,
              };
              setState(() {
                _events[nd] = (_events[nd] ?? [])..add(newEvent);
              });
              Navigator.pop(context);
            },
            child: const Text("Pridėti"),
          ),
        ],
      ),
    );
  }

  Future<void> _editEvent(DateTime date, Map<String, String> event) async {
    final titleCtrl = TextEditingController(text: event['title']);
    final descCtrl = TextEditingController(text: event['description']);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Redaguoti įvykį"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(hintText: "Pavadinimas"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(hintText: "Aprašymas"),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Atšaukti")),
          TextButton(
            onPressed: () {
              final nd = _normalize(date);
              final list = _events[nd]!;
              final idx = list.indexOf(event);
              if (idx != -1) {
                setState(() {
                  list[idx] = {
                    'title': titleCtrl.text,
                    'description': descCtrl.text,
                  };
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Išsaugoti"),
          ),
        ],
      ),
    );
  }

  void _deleteEvent(DateTime date, Map<String, String> event) {
    final nd = _normalize(date);
    setState(() {
      _events[nd]?.remove(event);
      if (_events[nd]?.isEmpty ?? false) _events.remove(nd);
    });
  }

  @override
  Widget build(BuildContext context) {
    // "Išplokštiname" visus įvykius su data
    final entries = <MapEntry<DateTime, Map<String, String>>>[];
    _events.forEach((date, list) {
      for (var ev in list) {
        entries.add(MapEntry(date, ev));
      }
    });
    entries.sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Calendar',
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
            TableCalendar<Map<String, String>>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (d) => isSameDay(_selectedDay, d),
              onDaySelected: (sel, fok) {
                setState(() {
                  _selectedDay = sel;
                  _focusedDay = fok;
                });
                _addEvent(sel);
              },
              eventLoader: _eventsForDay,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: const Color(0xFFEC407A),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: const Color(0xFFEC407A),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: const Color(0xFFEC407A),
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
                outsideDaysVisible: false,
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Visi įvykiai:', style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, i) {
                  final date = entries[i].key;
                  final ev = entries[i].value;
                  final fmt = DateFormat('yyyy-MM-dd').format(date);
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      title: Text(ev['title']!),
                      subtitle: Text(ev['description']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(fmt),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editEvent(date, ev),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteEvent(date, ev),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}