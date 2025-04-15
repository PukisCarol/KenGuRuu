import 'package:flutter/material.dart';
import 'package:kenguruu/pages/ToDoListPage.dart';
import 'pages/LogInPage.dart';
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
      //home: const NavigationBarApp(title: 'Flutter Demo Home Page'),
      home: const LogInPage(),
      //home: const ToDoListPage(title: 'ToDoList'), // DARANT INTEGRATION TESTUS ATKOMENTUOTI SITA IR UZKOMENTUOTI home: const LogInPage()
    );
  }
}