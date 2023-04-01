import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:transitx/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_page.dart';

var db;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
Future<void> handleSignOut() => googleSignIn.disconnect();

Future<void> currentUser() async {
  final GoogleSignInAccount? account = await googleSignIn.signIn();
  final GoogleSignInAuthentication authentication =
      await account!.authentication;

  final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: authentication.idToken, accessToken: authentication.accessToken);

  final UserCredential authResult = await auth.signInWithCredential(credential);
  final User? user = authResult.user;
  print(user!.displayName);
  print(user.displayName);
  print(user.displayName);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  db = FirebaseFirestore.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(
        title: 'TransitX',
      ),
    );
  }
}
