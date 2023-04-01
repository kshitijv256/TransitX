import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class Locator extends StatefulWidget {
  const Locator({super.key});

  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  String message = '';

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('live location Locatorer'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                _getLocation();
                setState(() {
                  message = 'location added';
                });
              },
              child: Text('add my location')),
          TextButton(
              onPressed: () {
                _listenLocation();
                setState(() {
                  message = 'live location enabled';
                });
              },
              child: Text('enable live location')),
          TextButton(
              onPressed: () {
                _stopListening();
                setState(() {
                  message = 'live location disabled';
                });
              },
              child: Text('stop live location')),
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
      await FirebaseFirestore.instance
          .collection('Transport')
          .doc('user1')
          .set({
        'lat': _locationResult.latitude,
        'long': _locationResult.longitude,
        'name': 'john',
        'type': 'bus',
        'route': '1'
      }, SetOptions(merge: true));
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
      await FirebaseFirestore.instance
          .collection('Transport')
          .doc('user1')
          .set({
        'lat': currentlocation.latitude,
        'long': currentlocation.longitude,
        'name': 'john',
        'type': 'bus',
        'route': '1'
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
