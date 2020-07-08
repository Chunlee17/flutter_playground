import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/bloc_provider_get_controller/counter_bloc.dart';

class BlocStateManagement extends StatefulWidget {
  @override
  _BlocStateManagementState createState() => _BlocStateManagementState();
}

class _BlocStateManagementState extends State<BlocStateManagement> {
  CounterBloc counterBloc;
  @override
  void initState() {
    counterBloc = BlocProvider.of<CounterBloc>(context)
      ..add(CounterEvent.increment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc State Mangement"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You have push the button many times: "),
            CounterDisplay(),
            Text(
              '${counterBloc.state}',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
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
      child: BlocConsumer<CounterBloc, dynamic>(
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
