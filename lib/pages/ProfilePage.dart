import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Services/auth_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> signout() async {
    await AuthService().signout(context: context);
  }

  @override
  Widget build(BuildContext context) {
    String? registrationDate = user?.metadata.creationTime?.toLocal().toString();
    return Scaffold(
      body: Stack(
        children: [
          // Radial gradient background (light pink to blue center)
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.pink.shade100,  // Light pink for the outer area
                  Colors.blue.shade500,  // Blue for the center
                ],
                center: Alignment.center,  // Center the gradient
                radius: 1.5,  // Full radius (spreads to full screen)
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
                    backgroundColor: Colors.pinkAccent,  // Pink button
                    foregroundColor: Colors.white,  // White text
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