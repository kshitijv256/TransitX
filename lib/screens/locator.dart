import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:transitx/main.dart';
import 'package:transitx/services/crud.dart';

class Locator extends StatefulWidget {
  const Locator({super.key});

  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  String message = '';
  var ref = FirebaseFirestore.instance.collection('Transport');
  late String type;
  late String route;

  getData() async {
    type = await ref.doc(driver).get().then((value) => value.data()!['type']);
    route = await ref.doc(driver).get().then((value) => value.data()!['route']);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 19, 14),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Location Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          GestureDetector(
            onTap: () {
              _getLocation();
              setState(() {
                message = 'location added';
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
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
              child: Text('Add Current Location',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              _listenLocation();
              setState(() {
                message = 'live location enabled';
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
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
              child: Text('Start Sharing',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              _stopListening();
              setState(() {
                message = 'live location disabled';
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
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
              child: Text('Stop Sharing',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(message),
          )
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseCrud.updateTransport(
          name: driver,
          lat: currentlocation.latitude!,
          long: currentlocation.longitude!);
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
}
