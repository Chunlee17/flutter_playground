import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';

class FlutterOverflowBox extends StatefulWidget {
  @override
  _FlutterOverflowBoxState createState() => _FlutterOverflowBoxState();
}

class _FlutterOverflowBoxState extends State<FlutterOverflowBox>
    with BasicPage {
  final double cellWidth = 200;
  final double cellHeight = 300;
  @override
  Widget body(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.red,
          width: cellWidth,
          height: cellHeight,
          child: OverflowBox(
            minHeight: cellHeight,
            maxHeight: cellHeight * 2,
            child: Column(
              children: List.generate(33, (index) => Text("Hello")),
            ),
          ),
        ),
        Container(
          child: Text("Below content"),
        ),
      ],
    );
  }

  @override
  String appBarTitle() {
    return "Flutter OverflowBox Widget";
  }
}
