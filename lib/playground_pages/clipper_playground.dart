import 'package:flutter/material.dart';

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
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height);
    path.conicTo(size.width / 2, 1, size.width, size.height, 1.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width / 2, 54, 0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
