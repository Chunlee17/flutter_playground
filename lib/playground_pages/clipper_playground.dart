import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_playground/constant/app_constant.dart';

class ClipperPlayground extends StatefulWidget {
  @override
  _ClipperPlaygroundState createState() => _ClipperPlaygroundState();
}

class _ClipperPlaygroundState extends State<ClipperPlayground> {
  final double circleRadius = 24;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Clipper Playground"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: primaryColor,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 80,
                      top: 0,
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: ClipPath(
                          clipper: LeafClipper(),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: ClipPath(
                        clipper: AppleClipper(),
                        child: Container(
                          width: 330,
                          height: 300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class AppleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double q3Width = size.width / 3;
    double q3Height = size.height / 3;
    double curvePoint = 32;
    final Path path = Path();
    //
    path.lineTo(curvePoint / 2, size.height / 2);
    //bottom left curve

    path.quadraticBezierTo(
      curvePoint / 2,
      size.height,
      q3Width,
      size.height - curvePoint / 2,
    );

    //middle bottom conic
    path.conicTo(
      size.width / 2,
      size.height - curvePoint,
      q3Width * 2,
      size.height - curvePoint / 2,
      1,
    );

    //bottom right curve
    path.quadraticBezierTo(
      size.width - 20,
      size.height,
      size.width - curvePoint / 2,
      q3Height * 2,
    );
    //middle right conic
    path.conicTo(
      size.width - (q3Width / 2),
      size.height / 2,
      size.width - curvePoint / 2,
      q3Height,
      1.8,
    ); //
    //top right curve
    path.quadraticBezierTo(
      size.width - 20,
      0,
      size.width - q3Width,
      curvePoint / 2,
    );

    //middle top conic
    path.conicTo(
      size.width / 2,
      curvePoint,
      q3Width,
      curvePoint / 2,
      1.4,
    );
    //top left curve
    path.quadraticBezierTo(
      20,
      0,
      curvePoint / 2,
      size.height / 2,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LeafClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height / 2);
    path.conicTo(
      size.width / 2,
      size.height,
      size.width,
      size.height / 2,
      1,
    );
    path.conicTo(
      size.width / 2,
      0,
      0,
      size.height / 2,
      1,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
