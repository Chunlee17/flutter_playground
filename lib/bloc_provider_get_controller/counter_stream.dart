import 'package:rxdart/rxdart.dart';

class CounterStream {
  int count = 0;
  BehaviorSubject<int> streamController = BehaviorSubject();

  Stream get stream => streamController.stream;

  void increment() async {
    count++;
    streamController.add(count);
    print(await streamController.length);
  }

  void decrement() {
    count--;
    streamController.add(count);
  }

  void addError() {
    streamController.addError("There's an error occur");
  }

  void dispose() async {
    await streamController.drain();
    print("counter bloc drain success");
    await streamController.close();
    print("Dispose counter bloc success");
  }
}
