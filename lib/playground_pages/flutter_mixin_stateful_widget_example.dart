import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class FlutterStatefulMixinExample extends StatefulWidget {
  @override
  _FlutterStatefulMixinExampleState createState() =>
      _FlutterStatefulMixinExampleState();
}

class _FlutterStatefulMixinExampleState
    extends State<FlutterStatefulMixinExample> with BasicPage {
  String title = "Flutter Stateful Mixin";
  @override
  String appBarTitle() {
    return title;
  }

  @override
  Widget body() {
    return Center(
      child: SmallFlatButton(
        onTap: () {
          setState(() {
            title = "New Title";
          });
        },
        child: Text(
          "This is my widget body without provide appBar because we already implement it in out BasicPage mixin\nClick me to change AppBar title",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
