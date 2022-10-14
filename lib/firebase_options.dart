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
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyABPTv9B0GbXVsk3qPXN6izTa7JwDfJ0Vo',
    appId: '1:822986831227:web:4ba3752addcd62b898f9de',
    messagingSenderId: '822986831227',
    projectId: 'stepbystep-365',
    authDomain: 'stepbystep-365.firebaseapp.com',
    storageBucket: 'stepbystep-365.appspot.com',
    measurementId: 'G-WM91MVT7F1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAb9fi9WS5rRMpqH1jfQfclAH7k02BaUMk',
    appId: '1:822986831227:android:19b42b882f95d50e98f9de',
    messagingSenderId: '822986831227',
    projectId: 'stepbystep-365',
    storageBucket: 'stepbystep-365.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaPVtF-wA2g926jf-DZ726Z6_58GbeWGE',
    appId: '1:822986831227:ios:aacf2a6ed28e17bb98f9de',
    messagingSenderId: '822986831227',
    projectId: 'stepbystep-365',
    storageBucket: 'stepbystep-365.appspot.com',
    iosClientId: '822986831227-o0nipi201456042ackra3r15mmq2ased.apps.googleusercontent.com',
    iosBundleId: 'com.example.stepbystep',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaPVtF-wA2g926jf-DZ726Z6_58GbeWGE',
    appId: '1:822986831227:ios:aacf2a6ed28e17bb98f9de',
    messagingSenderId: '822986831227',
    projectId: 'stepbystep-365',
    storageBucket: 'stepbystep-365.appspot.com',
    iosClientId: '822986831227-o0nipi201456042ackra3r15mmq2ased.apps.googleusercontent.com',
    iosBundleId: 'com.example.stepbystep',
  );
}