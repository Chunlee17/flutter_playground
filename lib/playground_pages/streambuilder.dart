import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:rxdart/rxdart.dart';

class StreamBuilderPlayground extends StatefulWidget {
  @override
  _StreamBuilderPlaygroundState createState() =>
      _StreamBuilderPlaygroundState();
}

class _StreamBuilderPlaygroundState extends State<StreamBuilderPlayground> {
  //publish subject can listen multiple time but not emit latest value when streambuilder initial
  PublishSubject<int> publishStream = PublishSubject();

  //###
  //replay subject can listen multiple time and store all latest value
  ReplaySubject<int> replayStream = ReplaySubject();

  //##
  //behavior subject can listen multiple time and single latest value
  BehaviorSubject<int> behaviorStream = BehaviorSubject();

  List<StreamController<int>> streamList;

  StreamController<int> selectedStream;

  bool showStream = true;
  int value = 0;

  void initializeStreamListener() {
    selectedStream.stream.listen(
      (data) async {
        print("stream data: $data");
      },
      onDone: () async {
        int length = await selectedStream.stream.length;
        int last = await selectedStream.stream.last;
        print("stream done with length: $length and last value: $last");
      },
      onError: (err) {
        print("stream error: $err");
      },
    );
  }

  @override
  void initState() {
    selectedStream = behaviorStream;
    selectedStream.add(10);
    initializeStreamListener();
    super.initState();
  }

  @override
  void dispose() {
    behaviorStream.close();
    publishStream.close();
    replayStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StreamBuilder playground"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            showStream
                ? StreamHandler<int>(
                    stream: selectedStream.stream,
                    ready: (snapshot) {
                      return Text(
                        "Stream value: $snapshot",
                        style: Theme.of(context).textTheme.headline6,
                      );
                    })
                : Text(
                    "Stream has been hide",
                    style: Theme.of(context).textTheme.headline6,
                  ),
            JinWidget.verticalSpace(32),
            ActionButton(
              onPressed: () {
                setState(() {
                  showStream = !showStream;
                });
              },
              child: Text(showStream ? "Hide Stream" : "Show Stream"),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ActionButton(
            stretch: false,
            onPressed: () {
              selectedStream.add(++value);
            },
            child: Text("Add Data to Stream"),
          ),
          ActionButton(
            stretch: false,
            onPressed: () {
              selectedStream.close();
            },
            child: Text("Close Stream"),
          ),
        ],
      ),
    );
  }
}
