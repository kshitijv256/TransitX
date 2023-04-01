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
    apiKey: 'AIzaSyAO3isRRJMFWthozRWErGw5Y43ITS18tRQ',
    appId: '1:254612421464:web:ba0457978413284b37032d',
    messagingSenderId: '254612421464',
    projectId: 'trxdemo-5f097',
    authDomain: 'trxdemo-5f097.firebaseapp.com',
    storageBucket: 'trxdemo-5f097.appspot.com',
    measurementId: 'G-PMN3P5VNTG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOie_KaPce4cPQXBIcw1al-s9ZeOTwkaM',
    appId: '1:254612421464:android:e83a8aa2a8aff9d237032d',
    messagingSenderId: '254612421464',
    projectId: 'trxdemo-5f097',
    storageBucket: 'trxdemo-5f097.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3LoXcxxIb0wuD0EmhnjDNkN5hP1jDMSw',
    appId: '1:254612421464:ios:4d9c3f0885bd0a6037032d',
    messagingSenderId: '254612421464',
    projectId: 'trxdemo-5f097',
    storageBucket: 'trxdemo-5f097.appspot.com',
    iosClientId:
        '254612421464-oai27at40khu9kia33rtt9hjt1uc2vqi.apps.googleusercontent.com',
    iosBundleId: 'com.example.transitx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3LoXcxxIb0wuD0EmhnjDNkN5hP1jDMSw',
    appId: '1:254612421464:ios:4d9c3f0885bd0a6037032d',
    messagingSenderId: '254612421464',
    projectId: 'trxdemo-5f097',
    storageBucket: 'trxdemo-5f097.appspot.com',
    iosClientId:
        '254612421464-oai27at40khu9kia33rtt9hjt1uc2vqi.apps.googleusercontent.com',
    iosBundleId: 'com.example.transitx',
  );
}
