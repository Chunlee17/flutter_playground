import 'dart:math';

import 'package:flutter/material.dart';

class HalfCircleClipper extends StatefulWidget {
  @override
  _HalfCircleClipperState createState() => _HalfCircleClipperState();
}

class _HalfCircleClipperState extends State<HalfCircleClipper> {
  final double circleRadius = 24;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haft Circle Clipper"),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width / 2,
                color: Colors.cyan,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 44),
                      child: CircleAvatar(
                        child: Icon(Icons.credit_card, color: Colors.white),
                        backgroundColor: Colors.pink,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(10, (index) {
                          return Container(width: 1, height: 6, color: Colors.white);
                        }),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "HELLO WORLD",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 54,
              child: ClipPath(
                clipper: CustomHalfCircleClipper(isTop: true),
                child: Container(
                  height: circleRadius,
                  width: circleRadius,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 54,
              child: ClipPath(
                clipper: CustomHalfCircleClipper(),
                child: Container(
                  height: circleRadius,
                  width: circleRadius,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ClipPath(
                clipper: TopTagClipper(),
                child: Container(
                  height: circleRadius * 3,
                  width: circleRadius * 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.green],
                    ),
                    //color: Colors.red,
                  ),
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(top: 12, right: 8),
                  child: Transform.rotate(
                    angle: pi / 4,
                    child: Text(
                      "15%",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  final bool isTop;
  CustomHalfCircleClipper({this.isTop = false});
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, isTop ? 0 : size.height),
      radius: size.width / 2,
    ));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TopTagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
