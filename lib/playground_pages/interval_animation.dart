import 'package:flutter/material.dart';

class IntervalAnimation extends StatefulWidget {
  @override
  _IntervalAnimationState createState() => _IntervalAnimationState();
}

class _IntervalAnimationState extends State<IntervalAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interval animation"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller.reset();
              _controller.forward();
            },
          )
        ],
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          var animation = Tween<double>(begin: 800.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval((1 / 10) * index, 1.0, curve: Curves.decelerate),
            ),
          );

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.translate(
              offset: Offset(0.0, animation.value),
              child: ListTile(
                title: Text("Hello animation $index"),
                subtitle: Text("nice app"),
                onTap: () {},
                leading: Icon(Icons.all_inclusive),
              ),
            ),
          );
        },
      ),
    );
  }
}
