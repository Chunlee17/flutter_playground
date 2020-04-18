import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/bloc/real_counter_bloc.dart';

class RealBlocPattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RealCounterBloc counterBloc =
        BlocProvider.of<RealCounterBloc>(context);
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
      child: BlocBuilder<RealCounterBloc, int>(
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
