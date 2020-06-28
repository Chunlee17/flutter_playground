import 'package:flutter/material.dart';
import 'package:flutter_playground/provider/counter_provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:provider/provider.dart';

class FlutterProvider extends StatefulWidget {
  @override
  _FlutterProviderState createState() => _FlutterProviderState();
}

class _FlutterProviderState extends State<FlutterProvider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Build page");
    return ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Provider"),
        ),
        body: Consumer<CounterProvider>(
          builder: (context, counter, snapshot) {
            print("Build Consumer with data: ${counter.count}");
            return Center(
              child: Text("Counter: ${counter.count}"),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: IncrementButton(),
      ),
    );
  }
}

class IncrementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = context.watch<CounterProvider>();
    return RawMaterialButton(
      onPressed: () {
        counter.increment();
      },
      fillColor: JinColorUtils.fromRGB(255, 196, 0),
      shape: StadiumBorder(),
      child: Text("Increment"),
    );
  }
}
