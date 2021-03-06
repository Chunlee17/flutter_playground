import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';

class DartInheritance extends StatefulWidget {
  @override
  _DartInheritanceState createState() => _DartInheritanceState();
}

class _DartInheritanceState extends State<DartInheritance> with BasicPage {
  Cat cat = Cat("Cat");
  Cat persian = Persian(name: "Persian");
  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Simeple cat name: ${cat.getName()}"),
          Text("Persian name: ${persian.name}"),
        ],
      ),
    );
  }

  @override
  String appBarTitle() {
    return "Dart Inheritance";
  }
}

abstract class Animal {
  int speed;
  String getName();
  void walk();
}

class Cat extends Animal {
  String name;
  Cat(this.name);

  @override
  String getName() {
    return this.name;
  }

  @override
  void walk() {
    print("cat walk");
  }
}

class Dog implements Animal {
  @override
  int speed;

  @override
  String getName() {
    // TODO: implement getName
    throw UnimplementedError();
  }

  @override
  void walk() {
    // TODO: implement walk
  }
}

class Persian extends Cat {
  int age;
  int length;
  String name;
  Persian({this.age, this.length, this.name}) : super(name);
}
