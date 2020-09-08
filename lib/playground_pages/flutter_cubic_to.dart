import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';

class FlutterCubicTo extends StatefulWidget {
  @override
  _FlutterCubicToState createState() => _FlutterCubicToState();
}

class _FlutterCubicToState extends State<FlutterCubicTo> with BasicPage {
  double x1 = 0;
  double x2 = 0;
  double y1 = 0;
  double y2 = 0;
  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipPath(
            child: Container(
              width: 200,
              height: 100,
              color: Colors.red,
            ),
            clipper: MyCubicToClipper(x1, y1, x2, y2),
          ),
          customSlider(
            min: 0,
            max: 200,
            value: x1,
            onChanged: (value) => setState(() => x1 = value),
          ),
          customSlider(
            min: 0,
            max: 100,
            value: y1,
            onChanged: (value) => setState(() => y1 = value),
          ),
          customSlider(
            min: 0,
            max: 200,
            value: x2,
            onChanged: (value) => setState(() => x2 = value),
          ),
          customSlider(
            min: 0,
            max: 100,
            value: y2,
            onChanged: (value) => setState(() => y2 = value),
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
  final double x1;
  final double y1;
  final double x2;
  final double y2;

  MyCubicToClipper(this.x1, this.y1, this.x2, this.y2);
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.cubicTo(
      size.width / 4,
      size.height,
      size.width / 4,
      size.height / 2,
      size.width / 2,
      size.height - 50,
    );

    path.cubicTo(
      size.width - size.width / 4,
      size.height / 2,
      size.width - size.width / 4,
      size.height,
      size.width,
      size.height,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
