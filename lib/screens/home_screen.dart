import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  double _originLatitude = 26.48424, _originLongitude = 50.04551;
  double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<PolylineId, Polyline> polylines = {};
  String googleAPiKey = "AIzaSyCoQAA8WPAbzwZ9bdEIGePohJ0rHQSrGyc";
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));

    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    // Location location = new Location();

    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    // LocationData _locationData;

    // _checkService() async {
    //   _serviceEnabled = await location.serviceEnabled();
    //   if (!_serviceEnabled) {
    //     _serviceEnabled = await location.requestService();
    //     if (!_serviceEnabled) {
    //       return;
    //     }
    //   }
    // }

    // _locationFetch() async {
    //   _permissionGranted = await location.hasPermission();
    //   if (_permissionGranted == PermissionStatus.denied) {
    //     _permissionGranted = await location.requestPermission();
    //     if (_permissionGranted != PermissionStatus.granted) {
    //       return;
    //     }
    //   }
    // }

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
        appBar: AppBar(title: Text("Map")),
        body: Stack(children: <Widget>[
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(_originLatitude, _originLongitude), zoom: 15),
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
          SlidingUpPanel(
            panel: Center(
              child: Text("This is the sliding Widget"),
            ),
            collapsed: Container(
              decoration:
                  BoxDecoration(color: Colors.blueGrey, borderRadius: radius),
              child: Center(
                child: Text(
                  "This is the collapsed Widget",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            body: Center(
              child: Text("This is the Widget behind the sliding panel"),
            ),
            borderRadius: radius,
          ),
        ]));
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
