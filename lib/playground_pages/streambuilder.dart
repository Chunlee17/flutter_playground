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
  //replay subject can listen multiple time and emit all latest value
  ReplaySubject<int> replayStream = ReplaySubject();

  //##
  //behavior subject can listen multiple time and single latest value
  BehaviorSubject<int> behaviorStream = BehaviorSubject();

  bool showStream = true;
  int value = 0;
  @override
  void initState() {
    behaviorStream.stream.listen((data) {
      print("stream data: $data");
    });
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showStream
                ? StreamHandler<int>(
                    stream: publishStream.stream,
                    ready: (snapshot) {
                      return Text("Stream value: $snapshot",
                          style: Theme.of(context).textTheme.headline6);
                    })
                : Text("Stream has been hide",
                    style: Theme.of(context).textTheme.headline6),
            JinWidget.verticalSpace(32),
            ActionButton(
              stretch: false,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          publishStream.add(++value);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
