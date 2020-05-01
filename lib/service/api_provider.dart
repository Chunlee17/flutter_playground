import 'package:dio/dio.dart';
import 'package:flutter_playground/models/post_model.dart';

class ApiProvider {
  ApiProvider._privateConstructor();
  final dio = Dio()..options.connectTimeout = 10000;

  static final ApiProvider _instance = ApiProvider._privateConstructor();

  factory ApiProvider() {
    return _instance;
  }

  Future<List<PostModel>> getPosts() async {
    try {
      Response response = await dio.get("https://jsonplaceholder.typicode.com/posts");
      return List<PostModel>.from(response.data.map((x) => PostModel.fromJson(x)));
    } catch (e) {
      throw e;
    }
  }
}
