// ignore_for_file: file_names

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAw36OqS1n5HcOOzGA_JEZ4FzoBlQCDmBM',
    appId: '1:168224632908:android:86d4ad150857ac992204e9',
    messagingSenderId: '168224632908',
    projectId: 'sharbek-app-61b6a',
    authDomain: 'sharbek-app-61b6a.firebaseapp.com',
    storageBucket: 'sharbek-app-61b6a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAw36OqS1n5HcOOzGA_JEZ4FzoBlQCDmBM',
    appId: '1:168224632908:android:86d4ad150857ac992204e9',
    messagingSenderId: '168224632908',
    projectId: 'sharbek-app-61b6a',
    storageBucket: 'sharbek-app-61b6a.appspot.com',
  );
}
