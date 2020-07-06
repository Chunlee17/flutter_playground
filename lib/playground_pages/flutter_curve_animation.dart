import 'dart:math';

import 'package:flutter/material.dart';

class FlutterCurveAnimationExample extends StatefulWidget {
  @override
  _FlutterCurveAnimationExampleState createState() =>
      _FlutterCurveAnimationExampleState();
}

class _FlutterCurveAnimationExampleState
    extends State<FlutterCurveAnimationExample>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: Offset.zero, end: Offset(100.0, 0.0))
        .animate(CurvedAnimation(
      curve: MountainCurves(),
      parent: controller,
    ));

    controller.repeat();
    super.initState();
  }

  double getValue(double value) {
    return sin(value * pi) * 200;
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
      body: Center(
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(animation.value.dx, getValue(controller.value)),
                child: CircleAvatar(radius: 32),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_circle_filled),
        onPressed: () {},
      ),
    );
  }
}

class MountainCurves extends Curve {
  @override
  double transformInternal(double t) {
    print(sin(pi * t * 2));
    //sin2pi = 0;
    return sin(pi * t * 4);
  }
}
