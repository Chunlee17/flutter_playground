import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class LocationRequestExample extends StatefulWidget {
  @override
  _LocationRequestExampleState createState() => _LocationRequestExampleState();
}

class _LocationRequestExampleState extends State<LocationRequestExample>
    with BasicPage {
  Geolocator geolocator = Geolocator();

  Future<Position> position;

  Future<Position> requuestUserPermission() async {
    try {
      bool serviceEnabled = await geolocator.isLocationServiceEnabled();
      print(serviceEnabled);
      Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (exception) {
      throw exception.toString();
    }
  }

  @override
  void initState() {
    position = requuestUserPermission();
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: FutureHandler<Position>(
        future: position,
        ready: (position) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Current Position is: "),
              Text("Latitude: ${position.latitude} "),
              Text("Longitude: ${position.longitude} "),
            ],
          );
        },
      ),
    );
  }

  @override
  String appBarTitle() {
    return "Location Permission Example";
  }
}
