import 'package:flutter_playground/provider/counter_provider.dart';

enum CheckNumber {
  IsOdd,
  IsEven,
}

class CheckNumberProvider {
  CheckNumber numberState;
  CheckNumberProvider({CounterProvider counter}) {
    numberState =
        counter.count % 2 == 0 ? CheckNumber.IsEven : CheckNumber.IsOdd;
  }
}
