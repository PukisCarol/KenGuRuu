import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaterTrackingPage extends StatefulWidget {
  const WaterTrackingPage({super.key, required String title});

  @override
  State<WaterTrackingPage> createState() => _WaterTrackingPageState();
}

class _WaterTrackingPageState extends State<WaterTrackingPage> {
  final List<Map<String, dynamic>> _waterRecords = [];
  final TextEditingController _controller = TextEditingController();
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _setCurrentDate();
  }

  void _setCurrentDate() {
    final now = DateTime.now();
    _currentDate = DateFormat('yyyy-MM-dd').format(now);
  }

  void _addWater() {
    final amount = double.tryParse(_controller.text);
    if (amount != null && amount > 0) {
      setState(() {
        _waterRecords.add({
          'date': _currentDate,
          'amount': amount,
          'timestamp': DateTime.now(),
        });
      });
      _controller.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vandens kiekis pridėtas')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Įveskite teigiamą skaičių')),
      );
    }
  }

  Map<String, double> _aggregateWaterByDate() {
    final Map<String, double> aggregated = {};
    for (var record in _waterRecords) {
      final date = record['date'] as String;
      final amount = record['amount'] as double;
      aggregated[date] = (aggregated[date] ?? 0) + amount;
    }
    return aggregated;
  }

  List<String> _getSortedDates() {
    final dates = _aggregateWaterByDate().keys.toList();
    dates.sort((a, b) => b.compareTo(a)); // Naujausia data pirmiau
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    final aggregatedWater = _aggregateWaterByDate();
    final sortedDates = _getSortedDates();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vandens Gėrimo Stebėjimas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Įvesties laukas ir mygtukas tik šiandienos datai
            if (sortedDates.isEmpty || sortedDates.first == _currentDate)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Įveskite vandens kiekį (ml)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addWater,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            // Lentelė su datomis ir vandens kiekiu
            Expanded(
              child: sortedDates.isEmpty
                  ? const Center(child: Text('Nėra įrašų'))
                  : ListView.builder(
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  final date = sortedDates[index];
                  final waterAmount = aggregatedWater[date]!.toStringAsFixed(0);
                  final isToday = date == _currentDate;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        date,
                        style: TextStyle(
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text('Išgerta: $waterAmount ml'),
                      trailing: isToday
                          ? IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              final dialogController = TextEditingController();
                              return AlertDialog(
                                title: const Text('Pridėti vandens kiekį'),
                                content: TextField(
                                  controller: dialogController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Kiekis (ml)',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Atšaukti'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      final amount = double.tryParse(dialogController.text);
                                      if (amount != null && amount > 0) {
                                        setState(() {
                                          _waterRecords.add({
                                            'date': _currentDate,
                                            'amount': amount,
                                            'timestamp': DateTime.now(),
                                          });
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Įveskite teigiamą skaičių'),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Pridėti'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                          : null,
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