import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_playground/bloc_provider_get_controller/mobx_counter.dart';

class MobXStateManagementExample extends StatefulWidget {
  const MobXStateManagementExample({Key key}) : super(key: key);

  @override
  _MobXStateManagementExampleState createState() =>
      _MobXStateManagementExampleState();
}

class _MobXStateManagementExampleState
    extends State<MobXStateManagementExample> {
  final _counter = MobXCounter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Observer(
                  builder: (_) => Text(
                        '${_counter.value}',
                        style: const TextStyle(fontSize: 20),
                      )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _counter.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}

class CounterDispay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = MobXCounter();
    return Container(
      child: Observer(
          builder: (_) => Text(
                '${_counter.value}',
                style: const TextStyle(fontSize: 20),
              )),
    );
  }
}
