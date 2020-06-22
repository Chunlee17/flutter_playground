import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class SwipeAction extends StatefulWidget {
  @override
  _SwipeActionState createState() => _SwipeActionState();
}

class _SwipeActionState extends State<SwipeAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Action"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ActionItem();
        },
      ),
    );
  }
}

class ActionItem extends StatefulWidget {
  @override
  _ActionItemState createState() => _ActionItemState();
}

class _ActionItemState extends State<ActionItem> {
  double actionWidth = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: actionWidth,
            color: Colors.red,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: SmallIconButton(
                    icon: Icon(Icons.add_a_photo),
                    onTap: () {},
                  ),
                ),
                Flexible(
                  child: SmallIconButton(
                    icon: Icon(Icons.add_call),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onHorizontalDragUpdate: (detail) {
                actionWidth += detail.primaryDelta;
                setState(() {
                  if (actionWidth > 100) actionWidth = 100;
                  if (actionWidth < 0.0) actionWidth = 0;
                });
              },
              child: Card(
                color: Colors.blue[100],
                child: ListTile(
                  title: Text("Action is coming"),
                  subtitle: Text("Swipe right to see action"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
