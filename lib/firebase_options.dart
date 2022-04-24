// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAybks3z5Oo31OF9n63RcK7csJEeu0uWV4',
    appId: '1:688087372190:web:596525c79919692467468f',
    messagingSenderId: '688087372190',
    projectId: 'airbnb-clone-48073',
    authDomain: 'airbnb-clone-48073.firebaseapp.com',
    databaseURL: 'https://airbnb-clone-48073.firebaseio.com',
    storageBucket: 'airbnb-clone-48073.appspot.com',
    measurementId: 'G-SKBTN8EZZG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTZuY1SI1ztN_yJvPAntADaT0nHIYdFRY',
    appId: '1:688087372190:android:a1f03330c46d720567468f',
    messagingSenderId: '688087372190',
    projectId: 'airbnb-clone-48073',
    databaseURL: 'https://airbnb-clone-48073.firebaseio.com',
    storageBucket: 'airbnb-clone-48073.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiS6fbhSYXeCOPyIhdMzRGubdm8s_kqM4',
    appId: '1:688087372190:ios:69622d2fc3541b8767468f',
    messagingSenderId: '688087372190',
    projectId: 'airbnb-clone-48073',
    databaseURL: 'https://airbnb-clone-48073.firebaseio.com',
    storageBucket: 'airbnb-clone-48073.appspot.com',
    iosClientId: '688087372190-e9iudmvbg3lnv1gam6l91ggmgip58j2h.apps.googleusercontent.com',
    iosBundleId: 'com.leave.app',
  );
}
