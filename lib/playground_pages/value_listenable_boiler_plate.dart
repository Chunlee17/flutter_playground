import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class ValueListenableBoilerPlate extends StatefulWidget {
  @override
  _ValueListenableBoilerPlateState createState() =>
      _ValueListenableBoilerPlateState();
}

class _ValueListenableBoilerPlateState
    extends State<ValueListenableBoilerPlate> {
  final count = 1.obs<int>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
      body: Center(
        child: ValueHandler(
          child: (data) => Text("Hello flutter: ${data}"),
          valueNotifier: count,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count.value++;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

extension test on dynamic {
  ValueNotifier<T> obs<T>() {
    return ValueNotifier<T>(this);
  }
}
