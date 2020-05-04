import 'package:flutter/material.dart';
import 'package:flutter_playground/bloc/counter_bloc.dart';
import 'package:flutter_playground/main.dart';

class BlocWithGetIt extends StatefulWidget {
  @override
  _BlocWithGetItState createState() => _BlocWithGetItState();
}

class _BlocWithGetItState extends State<BlocWithGetIt> {
  CounterBloc counterBloc;
  @override
  void initState() {
    counterBloc = getIt.get<CounterBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Bloc With GetIt"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You have push the button many times: "),
            CounterDisplay(),
          ],
        ),
      ),
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
        },
      ),
    );
  }
}
