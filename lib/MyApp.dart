import 'package:flutter/material.dart';

import 'NavigationBar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const NavigationBarApp(title: 'Flutter Demo Home Page'),
      //home: const LogInPage(),
    );
  }
}