import 'package:get/get.dart';

class CounterController extends GetxController {
  static CounterController get to => Get.find();

  int counter = 0;
  void increment() {
    counter++;
    update();
  }
}
