import 'package:flutter/material.dart';
import 'package:flutter_playground/models/counter_model.dart';
import 'package:flutter_playground/widgets/state_rebuilder_handler.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class StateRebuilderDemo extends StatefulWidget {
  @override
  _StateRebuilderDemoState createState() => _StateRebuilderDemoState();
}

class _StateRebuilderDemoState extends State<StateRebuilderDemo> {
  Counter counterModel;
  @override
  void initState() {
    counterModel = Injector.get<Counter>();
    super.initState();
  }

  Widget build(BuildContext context) {
    print("Rebuild setter");
    return Scaffold(
      appBar: AppBar(
        title: Text("State rebuilder Demo"),
      ),
      body: Center(child: CounterDisplay()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterModel.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  final Counter counterModel = Injector.get<Counter>();

  @override
  Widget build(BuildContext context) {
    print("Rebuild receiver");
    return Container(
      child: StateBuilderHandler<Counter>(
        model: counterModel,
        loading: CircularProgressIndicator(),
        error: (error) => Text(error, style: Theme.of(context).textTheme.title),
        builder: (context) {
          return Text(
            "You do not have error: ${counterModel.count}",
            style: Theme.of(context).textTheme.title,
          );
        },
      ),
    );
  }
}
