import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DummyPage extends StatefulWidget {
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dummy page"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 20,
                    color: Colors.red,
                  ),
                  Column(
                    children: <Widget>[
                      Text("Hello"),
                      Icon(Icons.accessible_forward),
                      Text("Skadoosh"),
                      RaisedButton(
                        child: Text("Click"),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
