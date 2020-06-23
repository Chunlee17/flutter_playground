import 'package:flutter/material.dart';
import 'package:flutter_playground/service/node-api-boilerplate-api.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:rxdart/rxdart.dart';

class NodeApiBoilerPlateTesting extends StatefulWidget {
  NodeApiBoilerPlateTesting({Key key}) : super(key: key);

  @override
  _NodeApiBoilerPlateTestingState createState() =>
      _NodeApiBoilerPlateTestingState();
}

class _NodeApiBoilerPlateTestingState extends State<NodeApiBoilerPlateTesting> {
  NodeApiBoilerPlateApi nodeApiBoilerPlate = NodeApiBoilerPlateApi();
  BehaviorSubject<String> loginController = BehaviorSubject();
  BehaviorSubject<String> userController = BehaviorSubject();
  var loginLoading = false.obs<bool>();
  var getInfoLoading = false.obs<bool>();

  Future onLoginUser() async {
    loginLoading.value = true;
    nodeApiBoilerPlate.loginUser().then(
      (response) {
        loginLoading.value = false;
        nodeApiBoilerPlate.token = response['token'];
        nodeApiBoilerPlate.userId = response['data']['_id'];
        loginController.add(response.toString());
      },
    ).catchError(
      (error) {
        loginLoading.value = false;
        loginController.addError(error.toString());
      },
    );
  }

  Future fetchUserInfo() async {
    getInfoLoading.value = true;
    nodeApiBoilerPlate.getUserInfo().then(
      (response) {
        userController.add(response.toString());
        getInfoLoading.value = false;
      },
    ).catchError(
      (error) {
        getInfoLoading.value = false;
        userController.addError(error.toString());
      },
    );
  }

  @override
  void dispose() {
    loginController.close();
    userController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Node Api Boilerplate"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ActionButton(
            child: Text("Login User"),
            onPressed: onLoginUser,
            isLoading: loginLoading,
          ),
          StreamHandler(
            stream: loginController.stream,
            initialData: "Not login yet",
            error: (error) => Text(
              error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            ready: (data) => Text(data.toString()),
          ),
          ActionButton(
            child: Text("Get User"),
            isLoading: getInfoLoading,
            onPressed: fetchUserInfo,
          ),
          StreamHandler(
            stream: userController.stream,
            error: (error) => Text(
              error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            initialData: "Login user first",
            ready: (data) => Text(data.toString()),
          ),
        ],
      ),
    );
  }
}
