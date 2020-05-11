import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class FlutterClipper extends StatefulWidget {
  @override
  _FlutterClipperState createState() => _FlutterClipperState();
}

class _FlutterClipperState extends State<FlutterClipper> {
  final double circleRadius = 24;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haft Circle Clipper"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
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
                              return Container(
                                  width: 1, height: 6, color: Colors.white);
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
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(16)),
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
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(24),
            foodCard(),
          ],
        ),
      ),
    );
  }

  Widget foodCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.55,
        decoration: BoxDecoration(color: Color(0xFF06B79D)),
        child: Row(
          children: <Widget>[
            ClipPath(
              clipper: FoodClipper(),
              child: Image.network(
                "https://picsum.photos/500",
                fit: BoxFit.cover,
              ),
            ).expanded,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.watch_later, color: Colors.white),
                Text("20min", style: TextStyle(color: Colors.white)),
                Icon(Icons.favorite, color: Colors.white),
                Text("130cal", style: TextStyle(color: Colors.white)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.shopping_cart),
                      Text("3/6"),
                    ],
                  ),
                ),
              ],
            ).padding(EdgeInsets.symmetric(horizontal: 16, vertical: 16))
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

class FoodClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.9, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width * 0.9, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
