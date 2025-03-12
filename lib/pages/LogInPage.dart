import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import '../MyApp.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}

class LogInPage extends StatefulWidget{
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();


}


class _LogInPageState extends State<LogInPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Colors.white,  // Švelni rožinė spalva
        Colors.blue.shade100 // Šiek tiek intensyvesnė rožinė
        ],
        begin: Alignment.topLeft,  // Pradžia
        end: Alignment.bottomRight,  // Pabaiga
    ),
    ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            // Pridėti wellness tematikos paveikslėlį
            Image.asset(
            'assets/4534968.png',  // Nurodykite teisingą kelio pavadinimą
            height: 150, // Pakeiskite pagal savo poreikius
            width: 150, // Pakeiskite pagal savo poreikius
            ),
            SizedBox(height: 40),
              Text(
                'Log in',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.pinkAccent.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'log in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Neturi paskyros? ', style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                      );
                    },
                    child: Text('Registruokis!', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registracija'),
      ),
      body: Center(
        child: Text('Čia bus registracijos forma'),
      ),
    );
  }
}