import 'package:dynamic_text_highlighting/dynamic_text_highlighting.dart';
import 'package:flutter/material.dart';

class RichTichSplitter extends StatefulWidget {
  @override
  _RichTichSplitterState createState() => _RichTichSplitterState();
}

class _RichTichSplitterState extends State<RichTichSplitter> {
  String test =
      "តារា​ម៉ូដែល​វ័យ​ក្មេង បញ្ជាក់​ថា រូប​គេ​មាន​និស្ស័យ​ស្រឡាញ់​សិល្បៈ​ដើរ​ម៉ូដ​នេះ​ជា​យូរ​មក​ហើយ ប៉ុន្តែ​ទើប​តែ​សម្រេច​ចិត្ត​ឈាន​ជើង​ចូល​នា​ពេល​នេះ ដោយ​សារ​ថា រូប​គេ​មិន​សូវ​មាន​ពេល​វេលា​ច្រើន​សម្រាប់​ការងារ​នេះ ផ្សំ​នឹង​វ័យ​ក្មេង​ផង ទើប​ចេះ​តែ​អូស​បន្លាយ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rich text Splitting"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            DynamicTextHighlighting(
              text: test,
              highlights: ["ត", "ថ"],
              color: Colors.yellow,
              style: TextStyle(fontSize: 18.0),
              caseSensitive: false,
              locale: Locale("km", "KH"),
            ),
            RaisedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(
                    Duration(days: 200),
                  ),
                  lastDate: DateTime.now().add(
                    Duration(days: 200),
                  ),
                  initialDate: DateTime.now(),
                );
              },
              child: Text("test"),
            ),
            SelectableText(
              'Hello! How are you?',
              toolbarOptions: ToolbarOptions(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
