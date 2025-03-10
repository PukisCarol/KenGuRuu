import 'package:flutter/material.dart';
//import '../MyApp.dart';

class LogInPage extends StatefulWidget{
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();

}

class _LogInPageState extends State<LogInPage>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(height: 10),

              Text('Hello again!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),

              SizedBox(height: 10),

              Text(
                'Sveiki grize',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0 ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0 ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Slaptazodis',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text('Prisijungti',
                        style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Neturi paskyros? ', style: TextStyle(
                  fontWeight: FontWeight.bold)
                  ),
                  Text('Prisiregistruok!', style: TextStyle(color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  ),
                ],
              )

            ],
            ),
          ),
        ),
    );
  }
}