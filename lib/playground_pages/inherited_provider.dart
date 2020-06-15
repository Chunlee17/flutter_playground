import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InheritedProviderDemo extends StatefulWidget {
  @override
  _InheritedProviderDemoState createState() => _InheritedProviderDemoState();
}

///Inherted Provider allow you to access data inside initState
class _InheritedProviderDemoState extends State<InheritedProviderDemo> {
  int data;
  @override
  void initState() {
    data = Provider.of<int>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inherited Provider Demo")),
      body: Center(
        child: Text(data.toString()),
      ),
    );
  }
}
