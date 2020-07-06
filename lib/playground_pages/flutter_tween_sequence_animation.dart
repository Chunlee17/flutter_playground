import 'package:flutter/material.dart';

class FlutterTweenSequenceAnimationExample extends StatefulWidget {
  @override
  _FlutterTweenSequenceAnimationExampleState createState() =>
      _FlutterTweenSequenceAnimationExampleState();
}

class _FlutterTweenSequenceAnimationExampleState
    extends State<FlutterTweenSequenceAnimationExample>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = TweenSequence<Offset>(
      <TweenSequenceItem<Offset>>[
        TweenSequenceItem<Offset>(
          tween: Tween<Offset>(begin: Offset.zero, end: Offset(100.0, 0.0))
              .chain(CurveTween(curve: Curves.ease)),
          weight: 30.0,
        ),
        TweenSequenceItem<Offset>(
          tween: Tween<Offset>(
                  begin: Offset(100.0, 0.0), end: Offset(100.0, 300.0))
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
        TweenSequenceItem<Offset>(
          tween: Tween<Offset>(
                  begin: Offset(100.0, 300.0), end: Offset(0.0, 300.0))
              .chain(CurveTween(curve: Curves.ease)),
          weight: 30.0,
        ),
        TweenSequenceItem<Offset>(
          tween: Tween<Offset>(begin: Offset(0.0, 300.0), end: Offset(0.0, 0.0))
              .chain(CurveTween(curve: Curves.ease)),
          weight: 30.0,
        ),
      ],
    ).animate(controller);
    super.initState();
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
        title: Text("Flutter Tween Sequence Animation"),
      ),
      body: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: animation.value,
              child: CircleAvatar(
                radius: 32,
                child: Text(
                  "My Animation",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_circle_filled),
        onPressed: () {
          controller.repeat();
        },
      ),
    );
  }
}
