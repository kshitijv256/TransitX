import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: (status)
              ? [
                  const SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: NetworkImage(user!.photoURL!),
                  ),
                  Text(
                    'Username: ${user!.displayName}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'Email: ${user!.email}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'Phone: ${user!.phoneNumber}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'UID: ${user!.uid}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  ElevatedButton(
                    onPressed: (() => {
                          handleSignOut,
                          auth.signOut(),
                          setState(() {
                            debugPrint('Signed out');
                            status = false;
                          }),
                          reassemble()
                        }),
                    child: const Text('Sign out'),
                  ),
                ]
              : [
                  ElevatedButton(
                    onPressed: (() async => {
                          await currentUser(),
                          setState(() {
                            debugPrint('Signed in');
                            status = true;
                          }),
                        }),
                    child: const Text('Sign in with Google'),
                  ),
                ],
        ),
      ),
    );
  }
}
