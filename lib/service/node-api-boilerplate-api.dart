import 'package:dio/dio.dart';

import 'node_api_boilerplatebase_api_provider.dart';

class NodeApiBoilerPlateApi extends NodeApiBoilerplateBaseApiProvider {
  NodeApiBoilerPlateApi._privateConstructor() {}
  static final NodeApiBoilerPlateApi _instance =
      NodeApiBoilerPlateApi._privateConstructor();

  factory NodeApiBoilerPlateApi() {
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
      if (response.data['status'] == 1)
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
      if (response.data['status'] == 1)
        return response.data;
      else
        throw response.data['message'];
    });
  }
}
