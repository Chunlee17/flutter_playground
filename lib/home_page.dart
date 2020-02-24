import 'package:flutter/material.dart';
import 'package:flutter_playground/streambuilder.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<Widget> pages = [
    StreamBuilderPlayground(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page selector"),
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          final page = pages[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.pages),
              title: Text(page.toString()),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
              },
            ),
          );
        },
      ),
    );
  }
}
