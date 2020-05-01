import 'package:flutter/material.dart';

class ScaffoldBoilerPlate extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget floatingActionButton;
  ScaffoldBoilerPlate({this.body, this.title, this.floatingActionButton});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
