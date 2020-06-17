import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/bloc/real_counter_bloc.dart';
import 'package:flutter_playground/provider/counter_provider_stream.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:provider/provider.dart';

class ProviderWithStream extends StatefulWidget {
  @override
  _ProviderWithStreamState createState() => _ProviderWithStreamState();
}

class _ProviderWithStreamState extends State<ProviderWithStream> {
  CounterProviderStream counterProviderStream;
  @override
  void initState() {
    super.initState();
    counterProviderStream =
        Provider.of<CounterProviderStream>(context, listen: false)..increment();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Bloc Pattern"),
      ),
      body: StreamHandler<Object>(
          stream: counterProviderStream.stream,
          ready: (snapshot) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("You have push the button many times: "),
                  CounterDisplay(),
                ],
              ),
            );
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            onPressed: () => counterProviderStream.increment(),
            child: Icon(Icons.add),
          ),
          RaisedButton(
            onPressed: () => counterProviderStream.addError(),
            child: Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProviderStream>(
      builder: (context, counter, _) => StreamHandler<Object>(
          stream: counter.stream,
          ready: (snapshot) {
            return Text(snapshot.toString());
          }),
    );
  }
}
