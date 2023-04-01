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
    // TODO: implement initState
    super.initState();
    // _getLocation();
  }

  loc.Location location = loc.Location();
  late loc.LocationData destination;
  late loc.LocationData origin;
  late GoogleMapController _controller;
  String google_api_key = "";
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Transport').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (_added) {
          mymap(snapshot);
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return Stack(children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            markers: {
              Marker(
                  position: LatLng(
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.user_id)['lat'],
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.user_id)['long'],
                  ),
                  markerId: MarkerId('id'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta)),
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.user_id)['lat'],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.user_id)['long'],
                ),
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
                  child: TextButton(
            child: snapshot.data!.docs
                .singleWhere((element) => element.id == widget.user_id)['name'],
            onPressed: getPolyPoints(origin, destination),
          ))),
        ]);
      },
    ));
  }

  List<LatLng> polylineCoordinates = [];
  getPolyPoints(origin, destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key, // Your Google Map Key
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude!, destination.longitude!),
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

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['longitude'],
            ),
            zoom: 14.47)));
  }
}
