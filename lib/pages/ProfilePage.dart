import 'package:flutter/material.dart';
import 'package:kenguruu/pages/ToDoPageDialogButtons.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  Widget build(BuildContext context) {
    String? registrationDate = user?.metadata.creationTime?.toLocal().toString();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Profilis'),
        elevation: 0,
      ),
      body: Center(
        heightFactor: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Jūsų prisijungimo paštas:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              user?.email ?? 'Nerastas el. paštas',
              style: TextStyle(fontSize: 20, color: Colors.grey[800]),
            ),
            SizedBox(height: 30),
            Text(
              'Jūsų prisijungimo data:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              registrationDate ?? 'Nerasta data',
              style: TextStyle(fontSize: 20, color: Colors.grey[800]),
            )
          ],
        ),
      ),
    );
  }
}