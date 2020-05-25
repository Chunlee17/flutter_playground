import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/page_list.dart';
import 'package:flutter_playground/widgets/page_card.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    pages.sort((page1, page2) {
      return page1.page.toStringShort().compareTo(page2.page.toStringShort());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Playground"),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          final page = pages[index];
          return PageCard(page: page);
        },
      ),
    );
  }
}
