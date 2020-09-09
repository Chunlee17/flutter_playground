import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';

class FlutterCubicTo extends StatefulWidget {
  @override
  _FlutterCubicToState createState() => _FlutterCubicToState();
}

class _FlutterCubicToState extends State<FlutterCubicTo> with BasicPage {
  double center = 80;
  double radius = 50;

  @override
  void initState() {
    center = radius;
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    double radius = 36;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipPath(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  color: Colors.red,
                ),
                clipper: MyCubicToClipper(center: center, radius: radius),
              ),
              Positioned(
                bottom: 0,
                left: center - 24 / 2,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          customSlider(
            min: radius,
            max: MediaQuery.of(context).size.width - radius,
            value: center,
            onChanged: (value) => setState(() => center = value),
          ),
        ],
      ),
    );
  }

  Widget customSlider(
      {double value, Function(double) onChanged, double min, double max}) {
    return Row(
      children: [
        Text("${value.toStringAsFixed(2)}"),
        Expanded(
          child: Slider(
            min: min,
            max: max,
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  String appBarTitle() {
    return "Flutter Cubic to";
  }
}

class MyCubicToClipper extends CustomClipper<Path> {
  final double center;
  final double radius;
  MyCubicToClipper({this.radius, this.center});
  @override
  Path getClip(Size size) {
    final path = Path();
    final double depth = 30;
    final double centerPivot = center ?? size.width / 2;
    path.lineTo(0, size.height);
    path.lineTo(centerPivot - radius, size.height);
    path.cubicTo(
      centerPivot - radius / 2,
      size.height,
      centerPivot - radius / 2,
      size.height - depth,
      //
      centerPivot,
      size.height - depth,
    );

    path.cubicTo(
      centerPivot + radius / 2,
      size.height - depth,
      centerPivot + radius / 2,
      size.height,
      //
      centerPivot + radius,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
