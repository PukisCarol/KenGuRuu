import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WaterTrackingPage extends StatefulWidget {
  const WaterTrackingPage({super.key, required String title});

  @override
  State<WaterTrackingPage> createState() => _WaterTrackingPageState();
}

class _WaterTrackingPageState extends State<WaterTrackingPage> {
  final List<Map<String, dynamic>> _waterRecords = [];
  final TextEditingController _controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  String _currentDate = '';
  bool _isLoading = true;
  final double _dailyGoal = 2000; // Tikslas: 2000 ml per dieną

  @override
  void initState() {
    super.initState();
    _setCurrentDate();
    _loadWaterData();
  }

  void _setCurrentDate() {
    final now = DateTime.now();
    _currentDate = DateFormat('yyyy-MM-dd').format(now);
  }

  Future<void> _loadWaterData() async {
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('water_tracking')
        .where('uid', isEqualTo: user!.uid)
        .get();

    final loadedRecords = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'date': data['date'] as String? ?? '',
        'amount': (data['amount'] as num?)?.toDouble() ?? 0.0,
        'timestamp': (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      };
    }).toList();

    setState(() {
      _waterRecords.clear();
      _waterRecords.addAll(loadedRecords);
      _isLoading = false;
    });
  }

  Future<void> _addWater(double amount) async {
    if (user == null) return;

    // Atnaujiname _currentDate, jei diena pasikeitė
    final now = DateTime.now();
    final newDate = DateFormat('yyyy-MM-dd').format(now);
    if (newDate != _currentDate) {
      setState(() {
        _currentDate = newDate;
      });
    }

    final entry = {
      'uid': user!.uid,
      'date': _currentDate,
      'amount': amount,
      'timestamp': FieldValue.serverTimestamp(),
    };

    setState(() {
      _waterRecords.add(entry);
    });

    await FirebaseFirestore.instance
        .collection('water_tracking')
        .add(entry);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vandens kiekis pridėtas')),
    );
  }

  void _onAddPressed() {
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
                  _addWater(amount);
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
    dates.sort((a, b) => b.compareTo(a));
    return dates;
  }

  double _calculateProgress() {
    final aggregatedWater = _aggregateWaterByDate();
    final currentWater = aggregatedWater[_currentDate] ?? 0;
    return (currentWater / _dailyGoal).clamp(0.0, 1.0); // Progresas nuo 0 iki 1
  }

  @override
  Widget build(BuildContext context) {
    final aggregatedWater = _aggregateWaterByDate();
    final sortedDates = _getSortedDates();
    final progress = _calculateProgress();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFD8F3FF), Color(0xFF5DCEFF)],
            stops: [0.0, 0.5962, 1.0],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 51),
              const Center(
                child: Text(
                  'Water tracker',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Color(0xFF55C1FF),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 161.79,
                      height: 155.15,
                      child: CircularProgressIndicator(
                        value: progress, // Progresas nuo 0 iki 1
                        strokeWidth: 10,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5DCCFC)),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(progress * _dailyGoal).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Color(0xFF5DCCFC),
                          ),
                        ),
                        const Text(
                          'ml of water drank',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Your last records:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Color(0xFF55C1FF),
                ),
              ),
              const SizedBox(height: 1), // Sumažintas tarpas
              Expanded(
                child: sortedDates.isEmpty
                    ? const Center(child: Text('Nėra įrašų'))
                    : ListView.builder(
                  itemCount: sortedDates.length,
                  itemBuilder: (context, index) {
                    final date = sortedDates[index];
                    final waterAmount = aggregatedWater[date]!.toStringAsFixed(0);

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        elevation: 0,
                        color: Colors.white.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                date,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Color(0xAA000000),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Išgerta: $waterAmount ml',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: Color(0xAA000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        backgroundColor: Colors.white.withOpacity(0.5),
        elevation: 0,
        child: const Text(
          '+',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 32,
            color: Color(0xFF5DCEFF),
          ),
        ),
      ),
    );
  }
}