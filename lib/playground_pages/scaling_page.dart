import 'dart:ui';

import 'package:flutter/material.dart';

class ScalingPage extends StatefulWidget {
  final String image;
  ScalingPage(this.image);
  @override
  _ScalingPageState createState() => _ScalingPageState();
}

class _ScalingPageState extends State<ScalingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> scale;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _controller,
    ));
    offset =
        Tween(begin: Offset.zero, end: Offset(0, 0.5)).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _controller,
    ));
    _controller.addListener(() {
      //print(_controller.value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return SlideTransition(
      position: offset,
      child: ScaleTransition(
        scale: scale,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Scaffold(
            appBar: AppBar(title: Text("Scaling page")),
            body: GestureDetector(
              onVerticalDragUpdate: (detail) {
                _controller.value += detail.primaryDelta / maxHeight * 2;
              },
              onVerticalDragEnd: (detail) {
                if (scale.value < 0.9) {
                  Navigator.of(context).pop();
                } else {
                  _controller.reverse();
                }
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                color: Colors.white,
                child: Hero(
                  tag: "Image",
                  child: Image.network(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
