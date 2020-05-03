import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class LerpAnimationDemo extends StatefulWidget {
  @override
  _LerpAnimationDemoState createState() => _LerpAnimationDemoState();
}

class _LerpAnimationDemoState extends State<LerpAnimationDemo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ScrollController scrollController;
  double maxHeight = 100;
  Animation<Offset> position;

  void toggleBottomSheet() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else
      _controller.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / maxHeight;
    print("Fling velocity: $flingVelocity");
    if (flingVelocity < 0.0)
      _controller.fling(velocity: -1);
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: 1);
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -1.0 : 1.0);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250))..forward();
    position = Tween(begin: Offset.zero, end: Offset(0, -1)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_controller.isCompleted && !_controller.isAnimating) {
          _controller.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter lerp animation"),
        elevation: 0.0,
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
      body: Column(
        children: <Widget>[
          SizeTransition(
            sizeFactor: _controller,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: GestureDetector(
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return SmallIconButton(
                      onTap: () {},
                      backgroundColor: Colors.red.shade200,
                      icon: Icon(Icons.account_balance_wallet, color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                return true;
              },
              child: ListView.builder(
                itemCount: 20,
                controller: scrollController,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("Hello Chunlee"));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
