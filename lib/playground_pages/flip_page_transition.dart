import 'package:flutter/material.dart';
import 'dummy_page.dart';

class FlipPageTransition extends StatefulWidget {
  @override
  _FlipPageTransitionState createState() => _FlipPageTransitionState();
}

class _FlipPageTransitionState extends State<FlipPageTransition>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> parentScale;
  Size size;
  double minScale = 0.8;

  static const transitionDuration = Duration(milliseconds: 2500);

  void viewDetail() async {
    controller.forward();
    await Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: transitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scale = Tween(begin: minScale, end: 1.0)
            .animate(CurvedAnimation(curve: Curves.linear, parent: animation));

        var transform = Matrix4.identity()
          ..setEntry(3, 2, 0.01)
          ..translate((1 - controller.value) * size.width)
          ..rotateY((1 - controller.value) * -0.1)
          ..scale(1.0, scale.value, 1.0);

        return Transform(
          transform: transform,
          alignment: Alignment.centerLeft,
          child: child,
        );
      },
      pageBuilder: (context, _, __) => DummyPage(),
    ));
    controller.reverse();
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: transitionDuration);
    parentScale = Tween(begin: 1.0, end: minScale).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      color: Colors.blueGrey,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform(
            alignment: Alignment.centerRight,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.01)
              ..translate(controller.value * -size.width)
              ..scale(1.0, parentScale.value, 1.0)
              ..rotateY(controller.value * 0.1),
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
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.009)
                        ..rotateY(0),
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
            ),
          );
        },
      ),
    );
  }
}
