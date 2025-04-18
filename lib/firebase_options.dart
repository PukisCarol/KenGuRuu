// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '',
    appId: '1:576301422095:web:1c4da4f6473a296d30b57a',
    messagingSenderId: '576301422095',
    projectId: 'kenguruu-d3874',
    authDomain: 'kenguruu-d3874.firebaseapp.com',
    storageBucket: 'kenguruu-d3874.firebasestorage.app',
    measurementId: 'G-D1P22HEGCQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:576301422095:android:850b414794a9d67030b57a',
    messagingSenderId: '576301422095',
    projectId: 'kenguruu-d3874',
    storageBucket: 'kenguruu-d3874.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: '',
    appId: '1:576301422095:web:600cccf9812b311a30b57a',
    messagingSenderId: '576301422095',
    projectId: 'kenguruu-d3874',
    authDomain: 'kenguruu-d3874.firebaseapp.com',
    storageBucket: 'kenguruu-d3874.firebasestorage.app',
    measurementId: 'G-60THVXYFHS',
  );
}
