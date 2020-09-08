import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class FlutterCustomPainter extends StatefulWidget {
  @override
  _FlutterCustomPainterState createState() => _FlutterCustomPainterState();
}

class _FlutterCustomPainterState extends State<FlutterCustomPainter> {
  double firstValue = 0.0;
  double secondValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom painter")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: CustomPaint(
                painter: MyPainter(firstValue, secondValue),
              ),
            ),
            SpaceY(250),
            Slider(
              min: -200,
              max: 200,
              onChanged: (value) {
                setState(() {
                  firstValue = value;
                });
              },
              value: firstValue,
            ),
            Slider(
              min: -200,
              max: 200,
              onChanged: (value) {
                setState(() {
                  secondValue = value;
                });
              },
              value: secondValue,
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.first, this.second);
  final double first;
  final double second;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    final path = Path();
    path.conicTo(size.width / 2, first, size.width, 0, 1);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  double radians(double degrees) => degrees * (3.141592 / 180.0);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
