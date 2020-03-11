import 'package:flutter/material.dart';

class FlutterPageViewEnlarge extends StatefulWidget {
  @override
  _FlutterPageViewEnlargeState createState() => _FlutterPageViewEnlargeState();
}

class _FlutterPageViewEnlargeState extends State<FlutterPageViewEnlarge> {
  PageController pageController;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.9);
    pageController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter PageView Enlarge"),
      ),
      body: Container(
        height: 200,
        margin: EdgeInsets.only(top: 16),
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            if (pageController.position.minScrollExtent == null || pageController.position.maxScrollExtent == null) {
              Future.delayed(Duration(microseconds: 1), () {
                setState(() {});
              });
              return Container();
            }
            double value = pageController.page - index;
            value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
            final double distortionValue = Curves.linear.transform(value);
            return Center(
              child: SizedBox(
                width: double.infinity,
                height: distortionValue * 200,
                child: Card(
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      "HELLO WORLD $index",
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
