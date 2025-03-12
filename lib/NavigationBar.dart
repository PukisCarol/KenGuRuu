import 'package:flutter/material.dart';
import 'MyApp.dart';
import 'pages/ToDoListPage.dart';
import 'pages/LogInPage.dart';
import 'pages/DiaryPage.dart';

class NavigationBarApp extends StatefulWidget {
  const NavigationBarApp({super.key, required this.title});

  final String title;

  @override
  State<NavigationBarApp> createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    LogInPage(),
    ToDoListPage(title: 'Uzdtuoties sarasas'),
    DiaryPage(title: 'Dienoraštis'),
    Center(
      child: Text(
        'Dar nepridetas puslapis :P',
        style: TextStyle(fontSize: 50),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'LogIn Langas'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Užduočių sąrašas'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dienoraštis'),
        ],
      ),
    );
  }
}
