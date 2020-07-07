import 'package:flutter/material.dart';

mixin BasicPage<Page extends StatefulWidget> on State<Page> {
  String appBarTitle();
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
