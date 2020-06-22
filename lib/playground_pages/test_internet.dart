import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:path_provider/path_provider.dart';

class TestInternetConnection extends StatefulWidget {
  @override
  _TestInternetConnectionState createState() => _TestInternetConnectionState();
}

class _TestInternetConnectionState extends State<TestInternetConnection> {
  var connection;

  Future<InternetAddress> getInternetConnection() async {
    final result = await InternetAddress.lookup('chunleethong.com');
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    Directory supportDir = await getApplicationSupportDirectory();
    String supportPath = supportDir.path;

    print("Temp paht: $tempPath");
    print("App Document path: $appDocPath");
    print("App Support path: $supportPath");
    return result[0];
  }

  @override
  void initState() {
    connection = getInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing internet connection"),
      ),
      body: Center(
        child: FutureHandler<InternetAddress>(
          future: connection,
          ready: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Host: ${data.host}"),
                Text("Raw Address: ${data.address}"),
              ],
            );
          },
        ),
      ),
    );
  }
}
