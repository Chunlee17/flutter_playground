import 'package:flutter_playground/models/base_model.dart';

class Counter extends BaseViewModel {
  bool isError = false;
  int count = 0;
  void increment() async {
    setState(ViewState.loading);
    await Future.delayed(Duration(milliseconds: 200));
    count++;
    setState(ViewState.ready);
  }
}
