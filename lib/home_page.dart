import 'package:flutter/material.dart';
import 'package:flutter_playground/playground_pages/container_shadow.dart';
import 'package:flutter_playground/playground_pages/firebase_face_detection.dart';
import 'package:flutter_playground/playground_pages/interval_animation.dart';
import 'package:flutter_playground/playground_pages/local_auth.dart';
import 'package:flutter_playground/playground_pages/look_rotation.dart';
import 'package:flutter_playground/playground_pages/scaling_page.dart';
import 'package:flutter_playground/playground_pages/sliver_persistent_header.dart';
import 'package:flutter_playground/playground_pages/state_rebuilder_demo.dart';
import 'package:flutter_playground/playground_pages/streambuilder.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<Widget> pages = [
    StreamBuilderPlayground(),
    ScalingPage(),
    IntervalAnimationPlayground(),
    FirebaseFaceDetectionDemo(),
    SliverPersistentHeaderDemo(),
    LookRotation(),
    LocalAuthenthicationDemo(),
    ContainerShadowDemo(),
    StateRebuilderDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page selector"),
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          final page = pages[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.pages),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              title: Text(page.toString()),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) => page,
                    transitionDuration: const Duration(milliseconds: 500),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero);
                      var offsetAnimaition = offset.animate(animation);
                      return SlideTransition(
                        child: child,
                        position: offsetAnimaition,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
