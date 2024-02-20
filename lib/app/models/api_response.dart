import 'package:dio/dio.dart';

class ApiResponse<T> {
  bool success;
  T? data;
  String? message;
  int? code;
  Response? raw;

  ApiResponse(
      {required this.success, this.data, this.message, this.code, this.raw});
}
