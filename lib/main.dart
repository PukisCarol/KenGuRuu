import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kenguruu/firebase_options.dart';

import 'MyApp.dart';
//tetsuojam ar veikia
//dar karta testuojam

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  runApp(
    CalendarControllerProvider(
        controller: EventController(),
        child: const MyApp(),
    )
  );
}






