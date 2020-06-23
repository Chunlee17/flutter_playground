import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'base_http_exception.dart';

class NodeApiBoilerplateBaseApiProvider {
  final dio = Dio()
    ..options.baseUrl = "https://chunlee-node-api-boilerplate.herokuapp.com"
    ..options.connectTimeout = 20000
    ..options.receiveTimeout = 20000;
  static JsonDecoder decoder = JsonDecoder();
  static JsonEncoder encoder = JsonEncoder.withIndent('  ');

  final unexpectedErrorMessage = "An unexpected error occur!";
  final socketErrorMessage =
      "Error connecting to server. Please check your internet connection or Try again later!";
  final timeOutMessage =
      "Connection timeout. Please check your internet connection or Try agian later!";

  NodeApiBoilerplateBaseApiProvider() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          print("${options.method}: ${options.path}");
          return options;
        },
        onResponse: (Response response) async {
          prettyPrintJson(response.data);
          return response; // continue
        },
        onError: (DioError error) async {
          return error; //continue
        },
      ),
    );
  }

  void prettyPrintJson(Map<String, dynamic> input) {
    //convert map to json String
    var prettyString = encoder.convert(input);
    prettyString.split('\n').forEach((element) => print(element));
  }

  Future<T> onRequest<T>(Function onHttpRequest) async {
    try {
      return await onHttpRequest();
    } on TypeError catch (exception) {
      print("Type Error Exception: ${exception.toString()}");
      print("Stack strace: ${exception.stackTrace.toString()}");
      throw exception;
    } on DioError catch (exception) {
      print("Dio Exception catch: ${exception.toString()}");
      if (exception.error is SocketException) {
        throw DioErrorException(socketErrorMessage);
      } else if (exception.type == DioErrorType.CONNECT_TIMEOUT) {
        throw DioErrorException(timeOutMessage);
      } else if (exception.type == DioErrorType.RESPONSE) {
        throw DioErrorException(
            "${exception.response.statusCode}: $unexpectedErrorMessage");
      } else {
        throw ServerErrorException(unexpectedErrorMessage);
      }
    } catch (exception) {
      throw ServerResponseException(exception.toString());
    }
  }
}
