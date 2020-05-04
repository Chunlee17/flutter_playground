import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class LookRotation extends StatefulWidget {
  @override
  _LookRotationState createState() => _LookRotationState();
}

class _LookRotationState extends State<LookRotation> {
  Offset tapOffset;
  Offset newOffset;
  double centerWidth;
  Offset centerOffset;
  DragUpdateDetails dragUpdateDetails;
  double angle = 0;
  double top = 0;
  double right = 0;
  double centerHeight;

  onContainerHorizontalDrag(DragUpdateDetails details) {
    setState(() {
      right = details.localPosition.distance;
      tapOffset = details.localPosition;
      newOffset = tapOffset - centerOffset;
      angle = atan2(newOffset.dy, newOffset.dx) * 180 / pi;
      angle += 90;
    });
  }

  onBodyContainerPanUpdate(DragUpdateDetails details) {
    setState(() {
      dragUpdateDetails = details;
      tapOffset = details.localPosition;
      newOffset = tapOffset - centerOffset;
      angle = atan2(newOffset.dy, newOffset.dx) * 180 / pi;
      angle += 90;
    });
  }

  @override
  Widget build(BuildContext context) {
    centerWidth = MediaQuery.of(context).size.width / 2;
    centerHeight = MediaQuery.of(context).size.height / 2;
    centerOffset = Offset(centerWidth, centerHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text("Look Rotation"),
      ),
      body: GestureDetector(
        onTap: () {},
        onPanUpdate: onBodyContainerPanUpdate,
        child: Container(
          color: Colors.black12,
          child: Stack(
            children: <Widget>[
              Center(
                child: Transform.rotate(
                  angle: degreeToRadian(-angle),
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Container(
                      width: 50,
                      height: 100,
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: right,
                child: GestureDetector(
                  onHorizontalDragUpdate: onContainerHorizontalDrag,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(newOffset.toString()), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
