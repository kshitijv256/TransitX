import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  loc.Location location = loc.Location();
  List points = [];
  List<TextButton> buttons = [];
  List markers = [];
  late loc.LocationData origin = loc.LocationData.fromMap({});
  late GoogleMapController _controller;
  String google_api_key = "";
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Transport').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (_added) {
          _getPoints(snapshot);
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                    position: LatLng(
                        origin.latitude ?? 27.2, origin.longitude ?? 75.69),
                    markerId: MarkerId('Your location'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta)),
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      origin.latitude ?? 27.2, origin.longitude ?? 75.69),
                  zoom: 14.47),
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  _controller = controller;
                  _added = true;
                });
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: const Color(0xFF7B61FF),
                  width: 6,
                ),
              },
            ),
            SlidingUpPanel(
              panel: Center(
                  child: ListView.builder(
                      itemCount: buttons.length,
                      itemBuilder: (BuildContext context, index) {
                        return buttons[index];
                      })),
              collapsed: Container(
                decoration:
                    BoxDecoration(color: Colors.blueGrey, borderRadius: radius),
                child: Center(
                  child: Text(
                    "Tap to see the Public Transports near you",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints(origin, lat, long) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key, // Your Google Map Key
      PointLatLng(origin.latitude ?? 27.2, origin.longitude ?? 75.69),
      PointLatLng(lat, long),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  _getLocation() async {
    try {
      loc.LocationData _locationResult = await location.getLocation();
      origin = _locationResult;
    } catch (e) {
      print(e);
    }
  }

  void _getPoints(AsyncSnapshot<QuerySnapshot> snapshot) async {
    snapshot.data!.docs.forEach((element) {
      points.add(element);
    });
    snapshot.data!.docs.forEach((element) {
      buttons.add(TextButton(
          onPressed: () =>
              getPolyPoints(origin, element['lat'], element['long']),
          child: Text(element['route'].toString())));
    });
    snapshot.data!.docs.forEach((element) {
      markers.add(
        Marker(
            position: LatLng(element['lat'], element['long']),
            markerId: MarkerId(element['route']),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta)),
      );
    });
  }
}
