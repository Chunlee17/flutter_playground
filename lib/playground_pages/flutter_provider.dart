import 'package:flutter/material.dart';
import 'package:flutter_playground/models/counter_provider.dart';
import 'package:provider/provider.dart';

class FlutterProvider extends StatefulWidget {
  @override
  _FlutterProviderState createState() => _FlutterProviderState();
}

class _FlutterProviderState extends State<FlutterProvider> {
  CounterProvider counterProvider;
  @override
  void initState() {
    counterProvider = Provider.of<CounterProvider>(context, listen: false)..increment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Build page");
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
