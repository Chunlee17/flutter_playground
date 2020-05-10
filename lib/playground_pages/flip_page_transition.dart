import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/scaffold_boiler_plate.dart';

import 'dummy_page.dart';

class FlipPageTransition extends StatefulWidget {
  @override
  _FlipPageTransitionState createState() => _FlipPageTransitionState();
}

class _FlipPageTransitionState extends State<FlipPageTransition> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> parentRotation;

  static const transitionDuration = Duration(milliseconds: 500);

  void viewDetail() async {
    animationController.forward();
    await Future.delayed(transitionDuration);
    await Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: transitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var angle = Tween(begin: pi / 2, end: 0.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
        );
        var transform = Matrix4.rotationY(angle.value);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      pageBuilder: (context, _, __) => DummyPage(),
    ));
    await Future.delayed(transitionDuration);
    animationController.reverse();
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: transitionDuration);
    parentRotation = Tween(begin: 0.0, end: pi / 2).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.identity(),
          // ..setEntry(3, 2, 0.01)
          // ..scale(1 - animationController.value * .5)
          // ..translate(animationController.value * -100)
          // ..rotateY(animationController.value),
          child: Scaffold(
            appBar: AppBar(title: Text("Flip Page Transition")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: viewDetail,
                    child: Text("View Detail"),
                  ),
                  Transform(
                    alignment: FractionalOffset.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.01)
                      ..scale(1 - animationController.value * .5)
                      ..translate(animationController.value * -100)
                      ..rotateY(animationController.value),
                    child: Container(
                      color: Colors.red,
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 24),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (animationController.isCompleted)
                  animationController.reverse();
                else
                  animationController.forward();
              },
              child: Icon(Icons.play_arrow),
            ),
          ),
        );
      },
    );
  }
}
