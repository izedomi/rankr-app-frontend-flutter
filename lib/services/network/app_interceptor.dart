import 'dart:async';
import 'package:dio/dio.dart';

import '../../app/print.dart';

class AppInterceptors extends QueuedInterceptorsWrapper {
  //Dio dio = Dio();
  CancelToken cancelToken = CancelToken();
  bool isTrustedDevice = true;

  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // printty(token);
    printty("base url:===> ${options.baseUrl}");
    printty("url path:===> ${options.path}");
    handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  FutureOr<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // ApiResponse res = DioResponseHandler.dioErrorHandler(err);

    return handler.next(err);
  }

  Future<void> logout() async {}
}
