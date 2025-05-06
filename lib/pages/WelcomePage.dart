import 'package:flutter/material.dart';
import '../Services/firestore_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomePage extends StatefulWidget {
  final String title;

  const WelcomePage({super.key, required this.title});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _showDescription = false;
  String _username = 'Vartotojas'; // Numatytasis vardas, jei neįkeliamas
  StreamSubscription<DocumentSnapshot>? _usernameSubscription;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showDescription = true);
    });
  }

  void _loadUsername() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _usernameSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((doc) {
        if (doc.exists && doc.data() != null) {
          setState(() {
            _username = doc.data()!['username'] ?? 'Vartotojas';
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _usernameSubscription?.cancel();
    super.dispose();
  }

  Widget get _meditationView => Container(
    key: const ValueKey('meditation'),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Welcome',
          style: GoogleFonts.pacifico(
            fontSize: 48,
            color: Color(0xFF5388A6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/Frame.png',
          width: 350,
          height: 350,
          fit: BoxFit.contain,
        ),
      ],
    ),
  );

  Widget get _descriptionView => Container(
    key: const ValueKey('description'),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/4534968.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20),
        Text(
          'Sveiki, $_username!',
          style: GoogleFonts.pacifico(
            fontSize: 48,
            color: Color(0xFF5388A6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Sveiki atvykę į mūsų saviugdos programėlę! '
                'Ši programėlė skirta jūsų savigdai ir asmenybės tobulėjimui.\n\n'
                'Pagrindinės funkcijos:\n'
                '- Įrašykite išgerto vandens kiekį kiekvieną dieną.\n'
                '- Stebėkite savo progresą per patogią lentelę.\n'
                '- Užsirašykite savo dienos užduotis ir jas atlikite.\n'
                '- Stebėkite savo kalendorių.\n\n'
                'Programa tinka visiems, kurie nori rūpintis savo dienotvarke!',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0.06),
            radius: 0.9565,
            colors: [
              Color(0xFFF1DCED),
              Color(0xFFA9C3E0),
              Color(0xFF69BCEC),
            ],
            stops: [0, 0.51, 1],
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _showDescription
              ? _descriptionView
              : _meditationView,
        ),
      ),
    );
  }
}