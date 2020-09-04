import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

const List<Map<String, dynamic>> datas = [
  {
    "name": "Chunlee",
    "age": 12,
  },
  {
    "name": "Chunlee4",
    "age": 67,
  },
  {
    "name": "Chunlee3",
    "age": 32,
  },
  {
    "name": "Chunlee33",
    "age": 11,
  },
  {
    "name": "Chunlee23",
    "age": 12,
  },
  {
    "name": "Chunlee123",
    "age": 32,
  },
  {
    "name": "Chunlee123",
    "age": 11,
  },
];

class DartFilterListByProperty extends StatefulWidget {
  @override
  _DartFilterListByPropertyState createState() => _DartFilterListByPropertyState();
}

class _DartFilterListByPropertyState extends State<DartFilterListByProperty> with BasicPage {
  Map<String, List<Map<String, dynamic>>> filtered = {};

  @override
  void initState() {
    datas.forEach((data) {
      filtered["${data['age']}"] ??= [];
      filtered["${data['age']}"].add(data);
    });
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return ListView(
      children: [
        ...filtered.keys.map((key) {
          return JinAccordion(
            title: Text(key),
            children: filtered[key].map((data) {
              return Text(data["name"]);
            }).toList(),
          );
        }).toList()
      ],
    );
  }

  @override
  String appBarTitle() {
    return context.widget.toStringShort();
  }
}
