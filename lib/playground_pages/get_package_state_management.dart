import 'package:flutter/material.dart';
import 'package:flutter_playground/models/get_counter_controller.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:get/get.dart';

class GetPackageStateManagement extends StatefulWidget {
  @override
  _GetPackageStateManagementState createState() =>
      _GetPackageStateManagementState();
}

class _GetPackageStateManagementState extends State<GetPackageStateManagement> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild page");
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Package"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You push the button"),
            GetBuilder<CounterController>(
              init: CounterController(),
              initState: (state) {},
              builder: (CounterController controller) {
                print("Rebuild builder");
                return Text(controller.counter.toString());
              },
            ),
            UIHelper.verticalSpace(),
            GetCounterButton(),
          ],
        ),
      ),
    );
  }
}

class GetCounterButton extends StatelessWidget {
  //final controller = Get.find<CounterController>();
  @override
  Widget build(BuildContext context) {
    // return RaisedButton(
    //   onPressed: () => controller.increment(),
    //   child: Text("Increment"),
    // );
    return GetBuilder<CounterController>(
      builder: (controller) => RaisedButton(
        onPressed: () => controller.increment(),
        child: Text("Increment"),
      ),
    );
  }
}
