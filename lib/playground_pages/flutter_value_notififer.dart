import 'package:flutter/material.dart';

import '../widgets/stateful_widget_mixin.dart';

class FlutterValueNotifierExample extends StatefulWidget {
  @override
  _FlutterValueNotifierExampleState createState() =>
      _FlutterValueNotifierExampleState();
}

class _FlutterValueNotifierExampleState
    extends State<FlutterValueNotifierExample> {
  ValueNotifier<int> counter = ValueNotifier(0);

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter ValueNofier Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder<int>(
              valueListenable: counter,
              builder: (context, counter, child) => Text("Counter: $counter"),
            ),
            RaisedButton(
              child: Text("Increment"),
              onPressed: () => counter.value++,
            )
          ],
        ),
      ),
    );
  }
}
