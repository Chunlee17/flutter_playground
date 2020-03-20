import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/models/route_model.dart';
import 'package:flutter_playground/utils/map_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:toast/toast.dart';

class GoogleMapPolyLineDemo extends StatefulWidget {
  @override
  State<GoogleMapPolyLineDemo> createState() => GoogleMapPolyLineDemoState();
}

class GoogleMapPolyLineDemoState extends State<GoogleMapPolyLineDemo> {
  Completer<GoogleMapController> _controller = Completer();
  final String token = 'pk.eyJ1IjoiY2h1bmxlZS10aG9uZyIsImEiOiJjazU3anl4ZzMwNHByM29vNHQ3aXVvZWxvIn0.5myktqzdMYAtWW9l3QUxCg';

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  List<LatLng> latLngList = List();
  CameraPosition currentCameraPosition = CameraPosition(target: LatLng(0, 0));
  Future<CameraPosition> pos;
  LatLng cameraLatlng;
  bool onInit = true;
  String address;
  double distanceBetweenPoint;

  Future<CameraPosition> getCurrentLocationService() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw "Location service disable";
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        throw "Location permission denied";
      }
    }
    _locationData = await location.getLocation();
    currentCameraPosition = CameraPosition(
      target: LatLng(_locationData.latitude, _locationData.longitude),
      zoom: 14.4746,
    );
    MarkerId markerId = MarkerId("CurrentLocation");
    final Uint8List customMarker = await MapUtils.getBytesFromCanvas();
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(customMarker),
      position: LatLng(_locationData.latitude, _locationData.longitude),
      onTap: () {
        print("I tap something");
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
    return currentCameraPosition;
  }

  void onGenerateRoute(LatLng latLng) async {
    try {
      await getRoute(currentCameraPosition.target, latLng);
      await getLocationAddress(latLng.latitude, latLng.longitude);
      PolylineId polylineId = PolylineId(latLng.hashCode.toString());
      final Polyline polyline = Polyline(
        polylineId: polylineId,
        visible: true,
        points: latLngList,
        width: 2,
        color: Colors.pink,
      );
      setState(() {
        polylines[polylineId] = polyline;
      });
    } catch (err) {
      Toast.show(err.toString(), context, duration: 3);
    }
  }

  Future<void> getLocationAddress(double lat, double lng) async {
    List<Placemark> placeMarks = await Geolocator().placemarkFromCoordinates(lat, lng);
    if (placeMarks.length > 0) {
      address = '${placeMarks[0].name}, ${placeMarks[0].thoroughfare}, ${placeMarks[0].subLocality}, ${placeMarks[0].locality}';
    }
  }

  Future<void> getRoute(LatLng position, LatLng desc) async {
    latLngList.clear();
    String requestUrl = 'https://api.mapbox.com/directions/v5/mapbox/driving/${desc.longitude},${desc.latitude};${position.longitude},'
        '${position.latitude}.json?access_token=$token&geometries=geojson&overview=simplified';
    var response = await Dio().get(requestUrl);
    RouteModel routeModel = RouteModel.fromJson(response.data);
    print(requestUrl);
    distanceBetweenPoint = routeModel.routes[0].distance;
    //MyWay welcome = MyWay.fromJson(response.data);
    for (var coordinate in routeModel.routes[0].geometry.coordinates) {
      double lat = coordinate[1];
      double lng = coordinate[0];
      latLngList.add(LatLng(lat, lng));
    }
    print('way points length: ' + latLngList.length.toString());
  }

  @override
  void initState() {
    pos = getCurrentLocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map Polyline"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => pos = getCurrentLocationService(),
          )
        ],
      ),
      body: FutureBuilder<CameraPosition>(
        future: pos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(markers.values),
                  polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: snapshot.data,
                  onCameraMove: (cameraPosition) {
                    onInit = false;
                    cameraLatlng = LatLng(cameraPosition.target.latitude.toDouble(), cameraPosition.target.longitude.toDouble());
                  },
                  onCameraIdle: () {
                    //if (onInit == false) onGenerateRoute(cameraLatlng);
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    //controller.showMarkerInfoWindow(MarkerId("CurrentLocation"));
                  },
                ),
                buildInstructionText(),
                buildDistanceInfo(),
                buildPinAnimation(),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Fetching current location, Please wait .....",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildPinAnimation() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 80,
        height: 80,
        margin: EdgeInsets.only(bottom: 12),
        child: FlareActor(
          "assets/pin.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "Search",
        ),
      ),
    );
  }

  Widget buildDistanceInfo() {
    return distanceBetweenPoint == null
        ? Container()
        : Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 4,
                    offset: Offset.zero,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 6,
                    child: Text(
                      "Distance to:\n$address",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.white,
                    height: 32,
                    width: 0.6,
                  ),
                  Text(
                    "${(distanceBetweenPoint / 1000).toStringAsFixed(2)} km",
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          );
  }

  Widget buildInstructionText() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          "Move the map generate route between your current location and destination",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
