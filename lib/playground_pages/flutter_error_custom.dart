import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';

class FlutterErrorCustom extends StatefulWidget {
  @override
  _FlutterErrorCustomState createState() => _FlutterErrorCustomState();
}

class _FlutterErrorCustomState extends State<FlutterErrorCustom>
    with BasicPage {
  List<int> data = [1, 2];
  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(child: ListTile(title: Text("HEllo"))),
          Card(child: ListTile(title: Text("HEllo"))),
          Card(child: ListTile(title: Text("HEllo"))),
          for (var index in [1, 2, 3]) Text(data[index].toString())
        ],
      ),
    );
  }

  @override
  String appBarTitle() {
    return "Flutter Error Custom";
  }
}
