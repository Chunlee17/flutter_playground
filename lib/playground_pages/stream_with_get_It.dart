import 'package:flutter/material.dart';
import 'package:flutter_playground/bloc_provider_get_controller/counter_stream.dart';
import 'package:flutter_playground/main.dart';

class StreamWithGetIt extends StatefulWidget {
  @override
  _StreamWithGetItState createState() => _StreamWithGetItState();
}

class _StreamWithGetItState extends State<StreamWithGetIt> {
  CounterStream counterBloc;
  @override
  void initState() {
    counterBloc = getIt.get<CounterStream>();
    super.initState();
  }

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream With GetIt"),
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
  final CounterStream counterBloc = getIt.get<CounterStream>();
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
