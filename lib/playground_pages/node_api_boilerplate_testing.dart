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

  Future onLoginUser() async {
    nodeApiBoilerPlate.loginUser().then(
      (response) {
        nodeApiBoilerPlate.token = response['token'];
        nodeApiBoilerPlate.userId = response['data']['_id'];
        loginController.add(response.toString());
      },
    ).catchError(
      (error) {
        loginController.addError(error.toString());
      },
    );
  }

  Future fetchUserInfo() async {
    nodeApiBoilerPlate.getUserInfo().then(
      (response) {
        userController.add(response.toString());
      },
    ).catchError(
      (error) {
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
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        children: <Widget>[
          ActionButton(
            child: Text("Login User"),
            onPressed: onLoginUser,
          ),
          StreamHandler(
            stream: loginController.stream,
            initialData: "Not login yet",
            error: (error) => Text(
              "Error: ${error.toString()}",
              style: TextStyle(color: Colors.red),
            ),
            ready: (data) => Text(data.toString()),
          ),
          ActionButton(
            child: Text("Get User"),
            onPressed: fetchUserInfo,
          ),
          StreamHandler(
            stream: userController.stream,
            error: (error) => Text(
              "Error: ${error.toString()}",
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
