import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart' as Jin;

class MotionAnimationExample extends StatefulWidget {
  @override
  _MotionAnimationExampleState createState() => _MotionAnimationExampleState();
}

class _MotionAnimationExampleState extends State<MotionAnimationExample>
    with BasicPage, SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> sizeFactor;
  double maxHeight = 100;

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
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
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..forward();
    sizeFactor = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            child: Card(
              color: Colors.redAccent[100],
            ),
          ),
          buildHeader(),
          buildBottomWidget(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return SizeTransition(
      sizeFactor: sizeFactor,
      child: Container(
        width: double.infinity,
        child: Card(
          color: Colors.lightGreenAccent[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
            child: Opacity(
              opacity: _controller.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Today is a beautiful day",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "I want to go to the beach today",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.accessibility_new,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomWidget() {
    return Expanded(
      child: GestureDetector(
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        child: Card(
          child: GridView.builder(
            itemCount: 20,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemBuilder: (_, index) {
              return Card();
            },
          ),
        ),
      ),
    );
  }

  @override
  String appBarTitle() {
    return "Motion Animation example";
  }
}
