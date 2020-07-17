import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlutterCustomRouteExample extends StatefulWidget {
  @override
  _FlutterCustomRouteExampleState createState() =>
      _FlutterCustomRouteExampleState();
}

class _FlutterCustomRouteExampleState extends State<FlutterCustomRouteExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Custom Route"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, SimpleModalRoute());
              },
              child: Text("Push to Modal Route"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, SimpleOverlayRoute());
              },
              child: Text("Push to Overlay Route"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    SimpleDialogRoute(AlertDialog(
                      title: Text("Hello"),
                      content: Text("Sur sdey"),
                    )));
              },
              child: Text("Push to Dialog Route"),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleModalRoute extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'This is a nice overlay',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Dismiss'),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class SimpleOverlayRoute extends OverlayRoute {
  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return [
      OverlayEntry(builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.black.withOpacity(0.5),
            alignment: Alignment.center,
            child: Text(
              "Hello overlay entry",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
        );
      }),
    ];
  }
}

class SimpleDialogRoute extends PopupRoute {
  final Widget child;

  SimpleDialogRoute(this.child);
  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, animationdouble, secondaryAnimation) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);
}
