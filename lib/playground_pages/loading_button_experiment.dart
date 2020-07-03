import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class LoadingButtonExperiment extends StatefulWidget {
  @override
  _LoadingButtonExperimentState createState() =>
      _LoadingButtonExperimentState();
}

class _LoadingButtonExperimentState extends State<LoadingButtonExperiment> {
  final isLoading = false.obs<bool>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading Button Experiment"),
      ),
      body: Center(
        child: MiniListTile(
          title: Text("Hello There"),
          onTap: () {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            isLoading.value = !isLoading.value;
          });
        },
      ),
    );
  }
}
