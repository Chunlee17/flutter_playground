import 'package:flutter/material.dart';
import 'package:flutter_playground/playground_pages/scaling_page.dart';
import 'package:flutter_playground/playground_pages/streambuilder.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<Widget> pages = [
    StreamBuilderPlayground(),
    ScalingPage(),
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
