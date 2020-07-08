import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oscilloscope/oscilloscope.dart';

class FlutterCurveAnimationExample extends StatefulWidget {
  @override
  _FlutterCurveAnimationExampleState createState() =>
      _FlutterCurveAnimationExampleState();
}

class _FlutterCurveAnimationExampleState
    extends State<FlutterCurveAnimationExample>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> firstAnimation;
  Animation<Offset> secondAnimation;
  Animation<Offset> waveAnimation;
  List<double> y = [];
  List<double> x = [];
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    firstAnimation = Tween(begin: Offset.zero, end: Offset(100.0, 0.0))
        .animate(CurvedAnimation(
      curve: Interval(0.0, 0.2, curve: Curves.bounceIn),
      parent: controller,
    ));

    secondAnimation = Tween(begin: Offset.zero, end: Offset(0.0, 200.0))
        .animate(CurvedAnimation(
      curve: Interval(0.3, 0.6, curve: Curves.linear),
      parent: controller,
    ));

    waveAnimation = Tween(begin: Offset.zero, end: Offset(0.0, 200.0))
        .animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));

    controller.repeat();
    super.initState();
  }

  double verticalValue() {
    double t = controller.value;
    double offset = sin(t * 8 * pi) * 100;
    y.add(offset);
    return offset;
  }

  double horizontalValue() {
    double t = controller.value;
    double offset = cos(t * 2 * pi) * 100;
    x.add(offset);
    return offset;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Curves Animation"),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Stack(
            children: <Widget>[
              // Transform.translate(
              //   offset: firstAnimation.value,
              //   child: CircleAvatar(radius: 32),
              // ),
              // Transform.translate(
              //   offset: secondAnimation.value,
              //   child: CircleAvatar(radius: 32),
              // ),

              Center(child: VerticalDivider()),
              Center(child: Divider()),
              Center(
                child: CircleAvatar(radius: 4, backgroundColor: Colors.black),
              ),
              Center(
                child: Transform.translate(
                  offset: Offset(
                    horizontalValue(),
                    verticalValue(),
                  ),
                  child: CircleAvatar(radius: 32),
                ),
              ),
              Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Text(
                        "Vertical Value: ${verticalValue().toStringAsFixed(2)}"),
                    Flexible(
                      child: Oscilloscope(
                        padding: 20.0,
                        backgroundColor: Colors.black,
                        traceColor: Colors.green,
                        yAxisMax: 100.0,
                        yAxisMin: -100.0,
                        dataSet: y,
                      ),
                    ),
                    Text(
                        "Horizontal Value: ${horizontalValue().toStringAsFixed(2)}"),
                    Flexible(
                      child: Oscilloscope(
                        padding: 20.0,
                        backgroundColor: Colors.black,
                        traceColor: Colors.green,
                        yAxisMax: 100.0,
                        yAxisMin: -100.0,
                        dataSet: x,
                      ),
                    ),
                    Text(
                        "Controller Value: ${controller.value.toStringAsFixed(2)}"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.pause),
        onPressed: () {
          controller.stop();
        },
      ),
    );
  }
}

class SinWaveCurve extends Curve {
  @override
  double transformInternal(double t) {
    return sin(pi * 2 * t);
  }
}
