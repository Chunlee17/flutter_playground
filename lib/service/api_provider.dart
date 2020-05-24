import 'dart:io';

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
        "https://jsonplaceholder.typicode.com/posts",
        options: buildCacheOptions(Duration(days: 10)),
      );
      return List<PostModel>.from(
          response.data.map((x) => PostModel.fromJson(x)));
    } catch (err) {
      handleExceptionError(err);
      return null;
    }
  }

  Future<PostModel> getSinglePost() async {
    try {
      Response response = await dio.get(
        "https://jsonplaceholder.typicode.com/posts/x",
        options: buildCacheOptions(Duration(days: 10)),
      );
      return PostModel.fromJson(response.data);
    } catch (err) {
      handleExceptionError(err);
      return null;
    }
  }

  String handleExceptionError(dynamic error) {
    print("Exception caught: ${error.toString()}");
    String errorMessage = "An unexpected error occur!";
    //Dio Error
    if (error is DioError) {
      if (error.error is SocketException) {
        errorMessage =
            'Error connecting to server. Please check your internet connection or Try again later!';
      } else if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorMessage =
            "Connection timeout. Please check your internet connection!";
      } else if (error.type == DioErrorType.RESPONSE) {
        errorMessage = "${error.response.statusCode}: $errorMessage";
      }
      throw errorMessage;

      //Json convert error
    } else if (error is TypeError) {
      errorMessage = "Convertion error";
      throw errorMessage;
      //Error message from server
    } else {
      throw error;
    }
  }
}
