import 'package:flutter/material.dart';
import '../Services/firestore_services.dart';

class WelcomePage extends StatelessWidget {
  final String username;

  const WelcomePage({super.key, required this.username, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sveiki!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Programėlės logotipas
            Image.asset('assets/4534968.png', width: 100, height: 100), // Pakeiskite į savo logotipą, pvz., Image.asset('assets/logo.png')
            const SizedBox(height: 20),
            // Sveikinimo užrašas su vartotojo vardu
            Text(
              'Sveiki, $username!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Programėlės aprašymas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Sveiki atvykę į mūsų saviugdos programėlę! '
                    'Ši programėlė skirta jūsų savigdai ir asmenybės tobulėjimui\n'
                    'Pagrindinės funkcijos: \n'
                    '- Įrašykite išgerto vandens kiekį kiekvieną dieną.\n'
                    '- Stebėkite savo progresą per patogią lentelę.\n'
                    '- Užsirašykite savo dienos užduotis ir jas atlikite.\n'
                    '- Stebėkite savo kalendorių.\n'
                    'Programa tinka visiems, kurie nori rūpintis savo dienotvarke!',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}