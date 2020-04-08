import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/models/attraction_model.dart';
import 'package:flutter_playground/models/route_model.dart';
import 'package:flutter_playground/utils/color_utils.dart';
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
  GoogleMapController googleMapController;
  final String token = 'pk.eyJ1IjoiY2h1bmxlZS10aG9uZyIsImEiOiJjazU3anl4ZzMwNHByM29vNHQ3aXVvZWxvIn0.5myktqzdMYAtWW9l3QUxCg';

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  List<LatLng> latLngList = List();
  CameraPosition currentCameraPosition = CameraPosition(target: LatLng(0, 0));
  Future<CameraPosition> pos;
  LatLng cameraLatlng;
  bool onInit = true;
  String address = '';
  double distanceBetweenPoint = 0;
  double mapPaddingBottom = 150;
  double mapPaddingLeft = 12;

  Future<AttractionModel> getAllAttraction() async {
    Response response = await Dio().get("https://travona-api.myoptistech.com/v1/services/mobile?count=5");
    print(response.data);
    return AttractionModel.fromJson(response.data);
  }

  Future<CameraPosition> getCurrentLocationService() async {
    MapUtils.index = 1;
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     throw "Location service disable";
    //   }
    // }
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.DENIED) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.GRANTED) {
    //     throw "Location permission denied";
    //   }
    // }
    // _locationData = await location.getLocation();
    AttractionModel attractionModel = await getAllAttraction();
    currentCameraPosition = CameraPosition(
      target: LatLng(13.3633, 103.8564),
      zoom: 14.4746,
    );

    for (var attraction in attractionModel.data) {
      MarkerId markerId = MarkerId(attraction.id);
      final Uint8List customMarker = await MapUtils.getBytesFromCanvas(imageUrl: attraction.thumbnails[0]);
      final Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(customMarker),
        position: LatLng(attraction.location.lat, attraction.location.long),
        onTap: () {
          print("I tap something");
        },
      );
      markers[markerId] = marker;
    }
    setState(() {});

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
  void dispose() {
    super.dispose();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LatLngBounds latLngBounds = await googleMapController.getVisibleRegion();
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.map, color: Colors.pink),
      ),
      body: FutureBuilder<CameraPosition>(
        future: pos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  padding: EdgeInsets.only(bottom: mapPaddingBottom, left: mapPaddingLeft),
                  markers: Set<Marker>.of(markers.values),
                  polylines: Set<Polyline>.of(polylines.values),
                  trafficEnabled: true,
                  buildingsEnabled: true,
                  mapToolbarEnabled: false,
                  tiltGesturesEnabled: true,
                  indoorViewEnabled: true,
                  initialCameraPosition: snapshot.data,
                  onCameraMove: (cameraPosition) {
                    onInit = false;
                    cameraLatlng = LatLng(cameraPosition.target.latitude.toDouble(), cameraPosition.target.longitude.toDouble());
                  },
                  onCameraIdle: () {
                    //if (onInit == false) onGenerateRoute(cameraLatlng);
                  },
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;

                    setState(() {});
                  },
                ),
                //buildDistanceInfo(),
                //buildPinAnimation(),
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
        margin: EdgeInsets.only(bottom: 12.0 + mapPaddingBottom, left: mapPaddingLeft),
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
    return Align(
      alignment: Alignment(1.0, .95),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    "Destination: $address",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  "${(distanceBetweenPoint / 1000).toStringAsFixed(2)} km",
                  style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(12),
              child: Text(
                "BOOK NOW",
                style: TextStyle(color: Colors.black),
              ),
              color: ColorUtils.getColorFromCode("ffeb50"),
            ),
          ),
        ],
      ),
    );
  }
}
