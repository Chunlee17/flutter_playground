import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/counter_inherited_widget.dart';

class FlutterInheritedWidget extends StatelessWidget {
  const FlutterInheritedWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = CounterInherited.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Inherited Widget"),
      ),
      body: Center(
        child: Text(counter.count.toString()),
      ),
    );
  }
}
