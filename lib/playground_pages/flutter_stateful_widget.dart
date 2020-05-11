import 'package:flutter/material.dart';

class FlutterStatefulWidget extends StatefulWidget {
  @override
  _FlutterStatefulWidgetState createState() => _FlutterStatefulWidgetState();
}

class _FlutterStatefulWidgetState extends State<FlutterStatefulWidget> {
  bool showChild = true;

  @override
  Widget build(BuildContext context) {
    print("Parent stateful build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter stateful"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  showChild = !showChild;
                });
              },
              child: Text("Show/Hide child"),
            ),
            if (showChild)
              AnotherStateFulWidget(key: UniqueKey())
            else
              Text("Hide child"),
          ],
        ),
      ),
    );
  }
}

class AnotherStateFulWidget extends StatefulWidget {
  AnotherStateFulWidget({Key key}) : super(key: key);
  @override
  _AnotherStateFulWidgetState createState() => _AnotherStateFulWidgetState();
}

class _AnotherStateFulWidgetState extends State<AnotherStateFulWidget>
    with AutomaticKeepAliveClientMixin {
  int count = 0;

  @override
  void initState() {
    print("child init state");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("Child stateful build");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(count.toString()),
          margin: EdgeInsets.symmetric(vertical: 32),
        ),
        RaisedButton(
          child: Text("Click Me"),
          onPressed: () {
            setState(() {
              count++;
            });
          },
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
