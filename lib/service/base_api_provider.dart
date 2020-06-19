import 'dart:io';
import 'package:dio/dio.dart';

class BaseApiProvider {
  final dio = Dio()
    ..options.baseUrl = "http://192.168.88.159:8000"
    ..options.connectTimeout = 20000
    ..options.receiveTimeout = 20000;

  BaseApiProvider() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          print("${options.method}: ${options.path}");
          return options;
        },
        onResponse: (Response response) async {
          return response; // continue
        },
        onError: (DioError error) async {
          print('Dio Error:' + error.message);
          return error; //continue
        },
      ),
    );
  }

  Future<T> onRequest<T>(Function onHttpRequest) async {
    try {
      return await onHttpRequest();
    } catch (exception) {
      throw handleExceptionError(exception);
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
      return errorMessage;

      //Json convert error
    } else if (error is TypeError) {
      errorMessage = "Convertion error: $error";
      return errorMessage;
      //Error message from server
    } else {
      return error.toString();
    }
  }
}
