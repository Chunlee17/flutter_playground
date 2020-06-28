import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class CustomDialogExample extends StatefulWidget {
  @override
  _CustomDialogExampleState createState() => _CustomDialogExampleState();
}

class _CustomDialogExampleState extends State<CustomDialogExample> {
  void showMyCustomDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => MyCustomDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Dialog"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Show Custom Dialog"),
          onPressed: showMyCustomDialog,
        ),
      ),
    );
  }
}

class MyCustomDialog extends StatefulWidget {
  @override
  _MyCustomDialogState createState() => _MyCustomDialogState();
}

class _MyCustomDialogState extends State<MyCustomDialog> {
  int currentStep = 0;

  List<String> introduction = [
    "Click here to add item to card",
    "Click here to checkout",
    "Click here to order"
  ];

  List<AlignmentGeometry> positions = [
    Alignment.centerRight,
    Alignment.bottomCenter,
    Alignment.topLeft,
  ];

  List<IconData> icons = [
    Icons.arrow_back,
    Icons.arrow_upward,
    Icons.arrow_forward,
  ];

  void onChangeStep() {
    currentStep++;
    if (currentStep >= 3)
      Navigator.pop(context);
    else
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: positions[currentStep],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icons[currentStep], color: Colors.white),
          ActionButton(
            stretch: false,
            elevation: 0,
            child: Text(introduction[currentStep]).textColor(Colors.white),
            onPressed: () {
              onChangeStep();
            },
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
