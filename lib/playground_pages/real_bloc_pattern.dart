import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/bloc/real_counter_bloc.dart';

class RealBlocPattern extends StatefulWidget {
  @override
  _RealBlocPatternState createState() => _RealBlocPatternState();
}

class _RealBlocPatternState extends State<RealBlocPattern> {
  RealCounterBloc counterBloc;
  @override
  void initState() {
    counterBloc = BlocProvider.of<RealCounterBloc>(context)..add(CounterEvent.increment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Bloc With GetIt"),
      ),
      body: Center(child: CounterDisplay()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterBloc.add(CounterEvent.increment),
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<RealCounterBloc, dynamic>(
        listener: (context, data) {
          print("We get data: $data");
        },
        builder: (context, count) {
          return Center(
            child: Text(
              '$count',
              style: TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
    );
  }
}
