import 'package:flutter/material.dart';
import 'package:flutter_playground/provider/counter_provider.dart';
import 'package:flutter_playground/provider/proxy_state_provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:provider/provider.dart';

class ProxyProviderDemo extends StatefulWidget {
  @override
  _ProxyProviderDemoState createState() => _ProxyProviderDemoState();
}

class _ProxyProviderDemoState extends State<ProxyProviderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proxy Provider Demo"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckNumberConsumer(),
            JinWidget.verticalSpace(24),
            CounterConsumer(),
          ],
        ),
      ),
    );
  }
}

class CheckNumberConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<CheckNumberProvider>(
        builder: (context, checkNumber, child) {
          return Text("My number state is: ${checkNumber.numberState}");
        },
      ),
    );
  }
}

class CounterConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<CounterProvider>(
        builder: (context, counter, child) {
          return Column(
            children: <Widget>[
              Text("My counter state is: ${counter.count}"),
              RaisedButton(
                child: Text("Increment"),
                onPressed: () => counter.increment(),
              ),
            ],
          );
        },
      ),
    );
  }
}
