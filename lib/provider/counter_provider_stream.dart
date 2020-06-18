import 'package:rxdart/rxdart.dart';

class CounterProviderStream {
  int _count = 0;
  BehaviorSubject<int> controller = BehaviorSubject();

  Stream get stream => controller.stream;

  CounterProviderStream();

  void increment() {
    _count++;
    controller.add(_count);
  }

  void addError() {
    controller.addError("There's an error occur");
  }

  void dispose() {
    controller.close();
  }
}
