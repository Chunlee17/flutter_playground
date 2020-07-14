import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class CustomExpansionTile extends StatefulWidget {
  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with BasicPage, SingleTickerProviderStateMixin {
  @override
  String appBarTitle() {
    return "Custom ExpansionTile";
  }

  AnimationController animationController;
  Animation<double> scale;
  bool isExpand = false;

  void onToggle() {
    if (animationController.isCompleted)
      animationController.reverse();
    else
      animationController.forward();
    //isExpand = !isExpand;
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scale = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: onToggle,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(12),
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Expansion Title"),
                  Icon(Icons.arrow_drop_down_circle),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: scale,
            child: Container(
              child: Text(
                "Tapping a GF Accordion expands or collapses the view of its children."
                "GFAccordion is used to collapse and expand the content"
                "to view the messages or the description of the given title",
              ),
            ),
          ),
          TextFormField(),
          ExpansionTile(
            title: Text("Click me"),
            children: <Widget>[
              Text("Hello"),
              RaisedButton(
                child: Text("Hello"),
                onPressed: () {},
              )
            ],
          ),
          TextFormField(),
        ],
      ),
    );
  }
}
