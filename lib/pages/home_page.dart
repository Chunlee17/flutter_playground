import 'package:flutter/material.dart';
import 'package:flutter_playground/main.dart';
import 'package:flutter_playground/pages/page_list.dart';
import 'package:flutter_playground/bloc_provider_get_controller/todo_db_provider.dart';
import 'package:flutter_playground/widgets/home_drawer.dart';
import 'package:flutter_playground/widgets/page_card.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoDBProvider todoProvider = getIt<TodoDBProvider>();
  @override
  void initState() {
    todoProvider.open('todo_db.db');
    pages.sort((page1, page2) {
      return page1.page.runtimeType
          .toString()
          .compareTo(page2.page.runtimeType.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Playground"),
      ),
      drawer: HomePageDrawer(),
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
