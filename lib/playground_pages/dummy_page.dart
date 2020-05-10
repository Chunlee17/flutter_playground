import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/scaffold_boiler_plate.dart';

class DummyPage extends StatefulWidget {
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldBoilerPlate(
      title: "Dummy Page",
    );
  }
}
