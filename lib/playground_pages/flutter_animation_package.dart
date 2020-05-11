import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/playground_pages/dummy_page.dart';

class FlutterAnimationPackage extends StatefulWidget {
  @override
  _FlutterAnimationPackageState createState() =>
      _FlutterAnimationPackageState();
}

class _FlutterAnimationPackageState extends State<FlutterAnimationPackage> {
  static const _fabDimension = 56.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animation Package"),
      ),
      body: Center(
        child: Text("Click Floating Action Button to Show Animation"),
      ),
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: Duration(seconds: 2),
        openBuilder: (BuildContext context, VoidCallback _) {
          return DummyPage();
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        closedColor: Theme.of(context).colorScheme.secondary,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: _fabDimension,
            width: _fabDimension,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        },
      ),
    );
  }
}
