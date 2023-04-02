import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:transitx/screens/welcome.dart';
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

String driver = "";
String googleMapsKey = "";

requestPermission() async {
  var status = await Permission.location.request();
  if (status.isGranted) {
    print('done');
  } else if (status.isDenied) {
    requestPermission();
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  requestPermission();
  googleMapsKey = await FirebaseFirestore.instance
      .collection('keys')
      .doc('googleMaps')
      .get()
      .then((value) => value.data()!['key']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}
