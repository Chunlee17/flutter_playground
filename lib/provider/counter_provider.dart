import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  @override
  void dispose() {
    print("Counter provider has been dispose");
    super.dispose();
  }
}
