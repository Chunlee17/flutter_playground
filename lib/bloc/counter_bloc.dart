import 'dart:async';

import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int count = 0;
  BehaviorSubject<int> streamController = BehaviorSubject();

  void increment() async {
    count++;
    streamController.add(count);
  }

  void decrement() {
    count--;
    streamController.add(count);
  }
}