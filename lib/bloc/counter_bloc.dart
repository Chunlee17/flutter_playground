import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int count = 0;
  BehaviorSubject<int> streamController = BehaviorSubject();

  void increment() async {
    count++;
    streamController.add(count);
    print(await streamController.length);
  }

  void decrement() {
    count--;
    streamController.add(count);
  }

  void dispose() async {
    await streamController.drain();
    print("counter bloc drain success");
    await streamController.close();
    print("Dispose counter bloc success");
  }
}
