import 'package:get/get.dart';

class CounterController extends GetController {
  static CounterController get to => Get.find();

  int counter = 0;
  void increment() {
    counter++;
    update(this);
  }
}
