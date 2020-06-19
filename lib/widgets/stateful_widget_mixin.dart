import 'package:flutter/material.dart';

abstract class BaseState<Page extends StatefulWidget> extends State<Page> {
  String appBarTitle();
}

mixin BasicPage<Page extends StatefulWidget> on BaseState<Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle()),
      ),
      body: body(),
    );
  }

  Widget body() => Container();
}
