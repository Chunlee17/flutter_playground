import 'package:mobx/mobx.dart';

part 'mobx_counter.g.dart';

class MobXCounter = CounterBase with _$MobXCounter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
