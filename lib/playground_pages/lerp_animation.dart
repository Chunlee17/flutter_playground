import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_playground/utils/color_utils.dart';

class LerpAnimationDemo extends StatefulWidget {
  @override
  _LerpAnimationDemoState createState() => _LerpAnimationDemoState();
}

class _LerpAnimationDemoState extends State<LerpAnimationDemo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double maxHeight;
  double minHeight;
  Color bottomSheetColor = ColorUtils.getColorFromCode("#d59ed6");

  void toggleBottomSheet() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else
      _controller.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: 1);
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: -1);
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  @override
  void initState() {
    minHeight = 32;
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    maxHeight = MediaQuery.of(context).size.height - 200;
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter lerp animation"),
        actions: <Widget>[
          IconButton(
            onPressed: toggleBottomSheet,
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, value) => Stack(
          children: <Widget>[
            Positioned(
              top: lerpDouble(maxHeight, minHeight, _controller.value),
              right: 0,
              left: 0,
              child: GestureDetector(
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                child: Container(
                  decoration: BoxDecoration(
                    color: bottomSheetColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    children: <Widget>[
                      handler(),
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 15,
                        itemBuilder: (context, index) => ListTile(
                          title: Text("HELLO $index"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget handler() {
    return Container(
      width: 54,
      height: 5,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }
}
