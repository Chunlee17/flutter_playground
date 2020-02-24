import 'dart:ui';

import 'package:flutter/material.dart';

class ScalingPage extends StatefulWidget {
  @override
  _ScalingPageState createState() => _ScalingPageState();
}

class _ScalingPageState extends State<ScalingPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scale = Tween(begin: 1.0, end: 0.7).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _controller,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Scaling page"),
          ),
          body: GestureDetector(
            onLongPressStart: (detail) {
              _controller.forward();
            },
            onLongPressEnd: (detail) {
              _controller.reverse();
            },
            onVerticalDragUpdate: (detail) {
              print(detail.primaryDelta);
            },
            onVerticalDragEnd: (detail) {
              if (detail.velocity.pixelsPerSecond != Offset.zero) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
