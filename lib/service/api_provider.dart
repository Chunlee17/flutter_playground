import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_playground/models/post_model.dart';

class ApiProvider {
  final dio = Dio()..options.connectTimeout = 10000;

  //#region Singletion
  ApiProvider._privateConstructor() {
    dio.interceptors.add(DioCacheManager(
            CacheConfig(baseUrl: "https://jsonplaceholder.typicode.com"))
        .interceptor);
  }
  static final ApiProvider _instance = ApiProvider._privateConstructor();

  factory ApiProvider() {
    return _instance;
  }
  //#endregion Singleton

  Future<List<PostModel>> getPosts() async {
    try {
      Response response = await dio.get(
        "https://jsonplaceholder.typicode.com/posts/5",
      );
      return List<PostModel>.from(
          response.data.map((x) => PostModel.fromJson(x)));
    } catch (err) {
      handleExceptionError(err);
      return null;
    }
  }

  void handleExceptionError(dynamic error) {
    print(error.toString());
    String errorMessage = "An unexpected error occur.";
    if (error is DioError) {
      if (error.message.contains('SocketException')) {
        errorMessage = 'No internet connection!';
      }
      throw error.error;
    }
    throw errorMessage;
  }
}
