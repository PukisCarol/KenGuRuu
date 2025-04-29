import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Services/auth_services.dart';
import 'package:kenguruu/pages/ToDoPageDialogButtons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Services/firestore_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserName();
    user = FirebaseAuth.instance.currentUser;
  }

  void loadUserName() async {
    final name = await FirestoreService().getUsername();
    if (name != null) {
      _controller.text = name;
    }
  }

  Future<void> signout() async {
    await AuthService().signout(context: context);
  }

  List names = [
  ];

  void saveName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final name = _controller.text.trim();

    if (uid != null && name.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': name,
      }, SetOptions(
          merge: true)); // merge so it doesn't overwrite existing data

      setState(() {
        names.add(_controller.text);
      });
    }
  }

    @override
    Widget build(BuildContext context) {
      String? registrationDate = user?.metadata.creationTime?.toLocal()
          .toString();
      return Scaffold(
        body: Stack(
          children: [
            // Radial gradient background (light pink to blue center)
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.pink.shade100, // Light pink for the outer area
                    Colors.blue.shade500, // Blue for the center
                  ],
                  center: Alignment.center, // Center the gradient
                  radius: 1.5, // Full radius (spreads to full screen)
                ),
              ),
            ),
            // Profile content centered
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Jūsų prisijungimo vardas:',
                    style: TextStyle(fontSize: 25, color: Colors.blue.shade800),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Įrašykite savo vardą',
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: MyButton(
                            key: Key('save_button'),
                            text: 'Išsaugoti',
                            onPressed: saveName,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Jūsų prisijungimo paštas:',
                    style: TextStyle(fontSize: 25, color: Colors.blue.shade800),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user?.email ?? 'Nerastas el. paštas',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Jūsų prisijungimo data:',
                    style: TextStyle(fontSize: 25, color: Colors.blue.shade800),
                  ),
                  SizedBox(height: 10),
                  Text(
                    registrationDate ?? 'Nerasta data',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: signout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent, // Pink button
                      foregroundColor: Colors.white, // White text
                    ),
                    child: Text('Atsijungti'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }