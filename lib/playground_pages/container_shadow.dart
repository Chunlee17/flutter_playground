import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ContainerShadowDemo extends StatefulWidget {
  @override
  _ContainerShadowDemoState createState() => _ContainerShadowDemoState();
}

class _ContainerShadowDemoState extends State<ContainerShadowDemo> {
  double blurRadius = 6;
  double spread = 6;
  Offset offset = Offset(0, 4);
  RangeValues rangeValues = RangeValues(0, 4);
  Color currentColor = Colors.grey;

  void pickColor() {
    Color pickerColor = Colors.grey.withOpacity(0.3);
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              setState(() {
                pickerColor = color;
              });
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Apply'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container shadow demo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 45),
          Text(
            "Offset: X: ${rangeValues.start.toStringAsFixed(4)} Y: ${rangeValues.end.toStringAsFixed(4)}",
            style: Theme.of(context).textTheme.title,
          ),
          RangeSlider(
            values: rangeValues,
            onChanged: (value) {
              setState(() {
                rangeValues = value;
              });
            },
            min: 0.0,
            max: 50,
          ),
          Container(
            width: 200,
            height: 200,
            margin: EdgeInsets.only(bottom: 32, top: 32),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.red,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: currentColor,
                  blurRadius: blurRadius,
                  spreadRadius: spread,
                  offset: Offset(rangeValues.start, rangeValues.end),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network("https://picsum.photos/200"),
            ),
          ),
          Text("Blur radius: ${blurRadius.toStringAsFixed(4)}", style: Theme.of(context).textTheme.title),
          Slider(
            onChanged: (value) {
              setState(() {
                blurRadius = value;
              });
            },
            min: 0.0,
            max: 20,
            value: blurRadius,
          ),
          Text("Spread radius: ${spread.toStringAsFixed(4)}", style: Theme.of(context).textTheme.title),
          Slider(
            onChanged: (value) {
              setState(() {
                spread = value;
              });
            },
            min: 0.0,
            max: 20,
            value: spread,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.color_lens),
        onPressed: pickColor,
      ),
    );
  }
}
