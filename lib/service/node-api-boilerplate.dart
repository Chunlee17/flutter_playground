import 'package:dio/dio.dart';
import 'package:flutter_playground/service/base_api_provider.dart';

class NodeApiBoilerPlate extends BaseApiProvider {
  NodeApiBoilerPlate._privateConstructor() {}
  static final NodeApiBoilerPlate _instance =
      NodeApiBoilerPlate._privateConstructor();

  factory NodeApiBoilerPlate() {
    return _instance;
  }

  String token;
  String userId;

  Future<dynamic> loginUser() async {
    return onRequest(() async {
      Response response = await dio.post(
        "/api/user/login",
        data: {
          "email": "chunlee@gmail.com",
          "password": "123456",
        },
      );
      if (response.statusCode == 200 && response.data['status'] == 1)
        return response.data;
      else
        throw response.data['message'];
    });
  }

  Future<dynamic> getUserInfo() async {
    return onRequest(() async {
      Response response = await dio.get(
        "/api/user/info/$userId",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200 && response.data['status'] == 1)
        return response.data;
      else
        throw response.data['message'];
    });
  }
}
