import 'package:flutter/material.dart';
import 'package:flutter_playground/home_page.dart';
import 'package:flutter_playground/models/counter_model.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
        inject: [
          Inject(() => Counter()),
        ],
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Playground',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.pink,
            ),
            home: MyHomePage(),
          );
        });
  }
}
