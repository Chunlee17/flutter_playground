import 'package:flutter/material.dart';
import 'package:flutter_playground/bloc_provider_get_controller/counter_stream.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:provider/provider.dart';

class ProviderWithStream extends StatefulWidget {
  @override
  _ProviderWithStreamState createState() => _ProviderWithStreamState();
}

class _ProviderWithStreamState extends State<ProviderWithStream> {
  CounterStream counterProviderStream;
  @override
  void initState() {
    super.initState();
    counterProviderStream = Provider.of<CounterStream>(context, listen: false)
      ..increment();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider with Pure stream"),
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
    return Consumer<CounterStream>(
      builder: (context, counter, _) => StreamHandler<int>(
        stream: counter.stream,
        error: (error) {
          return Column(
            children: <Widget>[
              Text(error),
              Icon(
                Icons.error,
                color: Colors.red,
              ),
            ],
          ).paddingValue(vertical: 32);
        },
        ready: (snapshot) {
          return Text(snapshot.toString()).textColor(Colors.red);
        },
      ),
    );
  }
}
