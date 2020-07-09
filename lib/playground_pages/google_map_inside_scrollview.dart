import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapInsideScrollView extends StatefulWidget {
  @override
  _GoogleMapInsideScrollViewState createState() =>
      _GoogleMapInsideScrollViewState();
}

class _GoogleMapInsideScrollViewState extends State<GoogleMapInsideScrollView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map Inside ScrollView"),
      ),
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          children: <Widget>[
            ...List.generate(
              10,
              (index) => ListTile(
                title: Text("Hello Flutter"),
              ),
            ).toList(),
            Container(
              width: double.infinity,
              height: 300,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(11.562108, 104.888535),
                  zoom: 10.4,
                ),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                ].toSet(),
              ),
            ),
            ...List.generate(
              10,
              (index) => ListTile(
                title: Text("Hello Flutter"),
              ),
            ).toList(),
          ],
        ),
      ),
    );
  }
}
