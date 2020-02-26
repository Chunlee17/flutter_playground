import 'dart:math';

import 'package:flutter_playground/models/base_model.dart';

class Counter extends BaseViewModel {
  bool isError = false;
  void increment() async {
    setState(ViewState.loading);
    await Future.delayed(Duration(milliseconds: 300));
    isError = Random().nextBool();
    if (isError) {
      setState(ViewState.error);
      errorMessage = "I have an error";
    } else
      setState(ViewState.ready);
  }
}
