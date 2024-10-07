import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.windows:
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtzcHkZJR0ORraEecvK5lRBu-DVYVX-Sg',
    appId: '1:808888806492:android:406573ababffbdfef28a99',
    messagingSenderId: '808888806492',
    projectId: 'nexten-ba1a6',
    databaseURL: '',
    storageBucket: '',
  );
}
