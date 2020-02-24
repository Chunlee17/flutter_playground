import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class StreamBuilderPlayground extends StatefulWidget {
  @override
  _StreamBuilderPlaygroundState createState() => _StreamBuilderPlaygroundState();
}

class _StreamBuilderPlaygroundState extends State<StreamBuilderPlayground> {
  //publish subject can listen multiple time but not emit latest value
  PublishSubject<int> streamController2 = PublishSubject();

  //###
  //replay subject can listen multiple time and emit all latest value
  ReplaySubject<int> streamController3 = ReplaySubject();

  //##
  //behavior subject can listen multiple time and single latest value
  BehaviorSubject<int> streamController = BehaviorSubject();

  bool showStream = true;
  int value = 0;
  @override
  void initState() {
    streamController.stream.listen((data) {
      print("stream data: $data");
    });
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    streamController2.close();
    streamController3.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StreamBuilder playground"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showStream
                ? StreamBuilder<int>(
                    stream: streamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.toString());
                      }
                      return Center(child: CircularProgressIndicator());
                    })
                : Text("No stream"),
            RaisedButton(
              onPressed: () {
                setState(() {
                  showStream = !showStream;
                });
              },
              child: Text("Show"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          streamController.add(++value);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}