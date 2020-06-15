import 'dart:io';

import 'package:flutter/material.dart';

class TestInternetConnection extends StatefulWidget {
  @override
  _TestInternetConnectionState createState() => _TestInternetConnectionState();
}

class _TestInternetConnectionState extends State<TestInternetConnection> {
  void getInternetConnection() async {
    final result = await InternetAddress.lookup('chunleethong.com');
    print(result.length);
    print(result[0].rawAddress);
    print(result[0].host);
  }

  @override
  void initState() {
    getInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
