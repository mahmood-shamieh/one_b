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
    apiKey: 'AIzaSyBzrRU0YRMx1ffwXtY9RXKgUSJN21ZmYwc',
    appId: '1:964349769021:web:354af034a89cd345e04154',
    messagingSenderId: '964349769021',
    projectId: 'testapp-4f937',
    authDomain: 'testapp-4f937.firebaseapp.com',
    storageBucket: 'testapp-4f937.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC57wf480TWcbWiC6jyAwbkHBlMTF9jlkU',
    appId: '1:451735399978:android:0a9fa729aeee3b629a9d53',
    messagingSenderId: '451735399978',
    projectId: 'my-bills-963c7',
    storageBucket: 'my-bills-963c7.appspot.com',
  );
}
