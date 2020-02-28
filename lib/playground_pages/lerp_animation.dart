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
    print('velocity value : $flingVelocity');
    if (flingVelocity < 0.0)
      _controller.fling(velocity: 1);
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: -1);
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  @override
  void initState() {
    minHeight = 120;
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    maxHeight = MediaQuery.of(context).size.height - 100;
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
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: _handleDragUpdate,
                  onVerticalDragEnd: _handleDragEnd,
                  child: Container(
                    height: lerpDouble(minHeight, maxHeight - 30, _controller.value),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: BoxDecoration(
                      color: bottomSheetColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    child: Column(
                      children: <Widget>[
                        handler(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
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
