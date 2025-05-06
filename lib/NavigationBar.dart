import 'package:flutter/material.dart';
import 'package:kenguruu/pages/CalendarPage.dart';
import 'package:kenguruu/pages/WaterTrackingPage.dart';
import 'pages/ToDoListPage.dart';
import 'pages/LogInPage.dart';
import 'pages/DiaryPage.dart';
import 'pages/ProfilePage.dart';
import 'pages/WaterTrackingPage.dart';
import 'pages/WelcomePage.dart';

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
    WelcomePage(title: 'Welcome'),
    ToDoListPage(title: 'Užduočių sąrašas'),
    WaterTrackingPage(title: 'Vandens sekimas'),
    DiaryPage(title: 'Dienoraštis'),
    CalendarPage(title: 'Kalendorius'),
    ProfilePage(title: 'Profilis'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Pagrindinis turinys
          Container(
            color: Colors.white,
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
        child: Container(
          color: Colors.white,
          height: 80, // Padidintas aukštis, kad tilptų turinys
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _navigateBottomBar,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFFF06DE6),
            unselectedItemColor: Color(0xFF5E5F60),
            backgroundColor: Colors.transparent,
            selectedLabelStyle: TextStyle(fontFamily: 'Figtree', fontSize: 13),
            unselectedLabelStyle: TextStyle(fontFamily: 'Figtree', fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/Vector-5.png', width: 24, height: 24),
                label: 'Welcome',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Vector-4.png', width: 24, height: 24),
                label: 'To do',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Vector-3.png', width: 24, height: 24),
                label: 'Water',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Vector-2.png', width: 24, height: 24),
                label: 'Diary',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Vector-1.png', width: 24, height: 24),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/Vector.png', width: 24, height: 24),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}