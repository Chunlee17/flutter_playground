import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class SwipeCardChild extends StatefulWidget {
  final Map people;
  final Function onIndexChange;

  const SwipeCardChild({Key key, this.people, this.onIndexChange})
      : super(key: key);
  @override
  _SwipeCardChildState createState() => _SwipeCardChildState();
}

class _SwipeCardChildState extends State<SwipeCardChild>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, lowerBound: 0.0, upperBound: 0.5)
          ..addListener(() {
            if (_controller.isCompleted) widget.onIndexChange();
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _controller.value +=
            details.primaryDelta / (MediaQuery.of(context).size.height * 2);
      },
      onHorizontalDragEnd: (details) {
        if (_controller.isAnimating ||
            _controller.status == AnimationStatus.completed) return;

        final double flingVelocity = details.velocity.pixelsPerSecond.dx /
            MediaQuery.of(context).size.height;
        print("Fling velocity: $flingVelocity");
        if (flingVelocity < 0.0)
          //reverse
          _controller.fling(velocity: -1);
        else if (flingVelocity > 0)
          //forward
          _controller.fling(velocity: 1);
        else
          _controller.fling(velocity: _controller.value < 0.5 ? -1.0 : 1.0);
      },
      child: RotationTransition(
        alignment: Alignment.bottomRight,
        turns: _controller,
        child: SlideTransition(
          position: Tween<Offset>(begin: Offset.zero, end: Offset(1.0, -1.0))
              .animate(_controller),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: JinWidget.radius(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.people["image"],
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[Icon(Icons.photo_library), Text("6")],
                ).padding(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SmallIconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onTap: () {},
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      "${widget.people["name"]}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .applyColor(Colors.white),
                    ),
                    SmallIconButton(
                      icon: Icon(Icons.favorite, color: Colors.pink),
                      onTap: () {},
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
