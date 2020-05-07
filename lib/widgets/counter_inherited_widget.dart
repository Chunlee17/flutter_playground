import 'package:flutter/material.dart';

class CounterInherited extends InheritedWidget {
  CounterInherited({Key key, this.child, this.count})
      : super(key: key, child: child);

  final int count;
  final Widget child;

  static CounterInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: CounterInherited);
  }

  @override
  bool updateShouldNotify(CounterInherited oldWidget) {
    return false;
  }
}
