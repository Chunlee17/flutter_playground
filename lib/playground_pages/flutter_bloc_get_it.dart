import 'package:flutter/material.dart';
import 'package:flutter_playground/bloc/counter_bloc.dart';
import 'package:flutter_playground/main.dart';

class FlutterBlocWithGetIt extends StatefulWidget {
  @override
  _FlutterBlocWithGetItState createState() => _FlutterBlocWithGetItState();
}

class _FlutterBlocWithGetItState extends State<FlutterBlocWithGetIt> {
  CounterBloc counterBloc;
  @override
  void initState() {
    counterBloc = getIt.get<CounterBloc>();
    super.initState();
  }

  @override
  void dispose() {
    //counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Bloc With GetIt"),
      ),
      body: Center(child: CounterDisplay()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterBloc.increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  final CounterBloc counterBloc = getIt.get<CounterBloc>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<int>(
          stream: counterBloc.streamController,
          builder: (context, snapshot) {
            return Text(
              "${counterBloc.count}",
              style: TextStyle(fontSize: 18),
            );
          }),
    );
  }
}
