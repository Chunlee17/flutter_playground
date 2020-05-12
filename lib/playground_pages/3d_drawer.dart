import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_playground/constant/app_constant.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class ThreeDDrawer extends StatefulWidget {
  @override
  _ThreeDDrawerState createState() => _ThreeDDrawerState();
}

class _ThreeDDrawerState extends State<ThreeDDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Size size;
  double maxSlide;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(curve: Curves.linear, parent: controller));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    maxSlide = size.width * 0.7;
    return Container(
      color: Colors.lightBlueAccent.shade100,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(maxSlide * animation.value, 0),
            child: Stack(
              children: <Widget>[
                Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-pi / 2.5 * animation.value),
                  child: Scaffold(
                    body: Center(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("GO BACK"),
                      ),
                    ),
                  ),
                ),
                buildAppBar(),
                buildDrawer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildAppBar() {
    return SafeArea(
      child: Container(
        height: AppBar().preferredSize.height,
        child: Material(
          type: MaterialType.transparency,
          child: Transform.translate(
            offset: Offset(animation.value, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if (controller.isCompleted)
                      controller.reverse();
                    else
                      controller.forward();
                  },
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: animation,
                  ).padding(),
                ),
                Opacity(
                  opacity: (1 - animation.value),
                  child: Text(
                    "Hello Flutter Cambodia",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ).padding(
                    EdgeInsets.only(left: 64),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Container(
      width: maxSlide,
      child: Transform.translate(
        offset: Offset(-maxSlide, 0),
        child: Drawer(
          elevation: 1.0,
          child: Container(
            color: primaryColor,
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  child: Center(
                    child: Text(
                      "My Drawer",
                      style: TextStyle(fontSize: 32),
                    ).textColor(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.add, color: Colors.white),
                  title: Text("Add Item").textColor(),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.new_releases, color: Colors.white),
                  title: Text("News").textColor(),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.photo, color: Colors.white),
                  title: Text("Photo").textColor(),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text("Setting").textColor(),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
