import 'package:flutter/material.dart';
import 'package:transitx/screens/get_driver.dart';
import 'package:transitx/screens/locator.dart';
import 'package:transitx/screens/tracker.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 29, 19, 14),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'TransitX',
            style: TextStyle(fontSize: 28),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetDriver()));
                },
                icon: Icon(Icons.bus_alert))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0,
              width: MediaQuery.of(context).size.width,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Tracker()));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.cyan[600],
                    gradient: LinearGradient(colors: [
                      Colors.red[400]!,
                      Colors.red[500]!,
                      Colors.red[700]!,
                      Colors.red[900]!
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text('Find Transport',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ));
  }
}
