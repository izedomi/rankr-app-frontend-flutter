import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../app/constants/app_text.dart';
import '../../app/env/env.dart';
import '../../app/models/api_response.dart';
import '../../app/print.dart';
import 'app_interceptor.dart';
import 'dio_response_handler.dart';

class DioApiService {
  int timeOutDurationInSeconds = 30;
  int connectionTimeout = 6000;
  AppInterceptors appInterceptors;
  late Dio dio;

  var options = BaseOptions(
    baseUrl: Env().config.baseUrl,
    connectTimeout: const Duration(seconds: 6000),
    receiveTimeout: const Duration(seconds: 3000),
  );

  DioApiService(this.appInterceptors) {
    dio = Dio(options);
    dio.interceptors.add(appInterceptors);
    Map<String, dynamic> headers = {'Accept': 'application/json'};
    dio.options.headers = headers;
  }

  Future<ApiResponse> post(
      {required Map<String, dynamic> body,
      required var url,
      String? baseUrl,
      Map<String, dynamic>? headers,
      bool trackData = true,
      String? token}) async {
    try {
      var options = BaseOptions();
      options.baseUrl = baseUrl ?? Env().config.baseUrl;
      if (headers != null && headers.isNotEmpty) {
        options.headers.addAll(headers);
      }
      if (token != null) {
        options.headers.addAll({"authorization": "Bearer $token"});
      }

      printty("url: ${options.baseUrl}");
      printty("path: $url");

      Response response = await Dio(options)
          .post(url, data: body)
          .timeout(Duration(seconds: timeOutDurationInSeconds));

      printty("headers: ${response.headers}");

      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e) {
      printty(e.toString());
      printty(e.requestOptions.headers.toString());

      return DioResponseHandler.dioErrorHandler(e);
    } on TimeoutException catch (_) {
      return ApiResponse(success: false, message: AppText.timeoutMsg);
    } catch (e) {
      return ApiResponse(success: false, message: AppText.errorMsg);
    }
  }

  Future<ApiResponse> get({required String url, String? token}) async {
    try {
      var options = BaseOptions();
      //options.baseUrl = Env().config.baseUrl;
      // options.headers = await getDeviceHeaders();
      if (token != null) {
        options.headers.addAll({"authorization": "Bearer $token"});
      }

      printty(options.baseUrl);
      printty(url);

      Response response = await Dio(options)
          .get(url)
          .timeout(Duration(seconds: timeOutDurationInSeconds));

      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    } on TimeoutException catch (_) {
      return ApiResponse(success: false, message: AppText.timeoutMsg);
    } catch (e) {
      return ApiResponse(success: false, message: AppText.errorMsg);
    }
  }

  Future<ApiResponse> put(
      {required Map<String, dynamic> body, required var url}) async {
    try {
      //await HeaderService().getDeviceInfo();
      var options = BaseOptions();
      // options.baseUrl = Env().config.baseUrl;
      //options.headers = await getDeviceHeaders();
      Response response = await Dio(options)
          .put(url, data: FormData.fromMap(body))
          .timeout(Duration(seconds: timeOutDurationInSeconds));
      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    } on TimeoutException catch (_) {
      return ApiResponse(success: false, message: AppText.timeoutMsg);
    }
  }

  Future<ApiResponse> postWithAuth({
    var body,
    required var url,
    bool canRetry = true,
    String? contentType,
    Map<String, dynamic>? header,
    bool hasFile = false,
  }) async {
    try {
      if (contentType != null) {
        dio.options.contentType = contentType;
      }

      if (header != null) {
        dio.options.headers.addAll(header);
      }

      dynamic data = body;

      printty("url before post call...$url");

      Response response = hasFile
          ? await dio
              .post(url, data: FormData.fromMap(body))
              .timeout(Duration(seconds: timeOutDurationInSeconds))
          : await dio
              .post(url, data: data != null ? json.encode(data) : null)
              .timeout(Duration(seconds: timeOutDurationInSeconds));

      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e, s) {
      printty(e.toString());
      printty(s.toString());

      return DioResponseHandler.dioErrorHandler(e);
    } on TimeoutException catch (_) {
      return ApiResponse(success: false, message: AppText.timeoutMsg);
    } catch (e) {
      return ApiResponse(success: false, message: AppText.errorMsg);
    }
  }

  Future<ApiResponse> getWithAuth({
    var body,
    required var url,
    bool canRetry = true,
    bool trackAction = true,
  }) async {
    try {
      //  return await getWithHttp(url: url, tokenUtil: tokenUtil);
      // String? token =
      //     await tokenUtil?.getToken() ?? await TokenUtil().getToken();
      // String? refreshToken = await tokenUtil?.getRefreshToken() ??
      //     await TokenUtil().getRefreshToken();

      // if (token == null || refreshToken == null) {
      //   return ApiResponse(
      //       success: false,
      //       message: "Invalid request. Sign in required!",
      //       code: 401);
      // }

      // await SecureStorageUtils.saveAccessToken(value: token);
      // await SecureStorageUtils.saveRefreshToken(value: refreshToken);

      printty("url before get call....$url");
      Response response = await dio
          .get(url)
          .timeout(Duration(seconds: timeOutDurationInSeconds));

      if (trackAction) {}
      return DioResponseHandler.parseResponse(response);
    } on DioException catch (e) {
      return DioResponseHandler.dioErrorHandler(e);
    } on TimeoutException catch (_) {
      return ApiResponse(success: false, message: AppText.timeoutMsg);
    } catch (e) {
      return ApiResponse(success: false, message: AppText.errorMsg);
    }
  }

  Future<ApiResponse> logout() async {
    return ApiResponse(
        code: 401, success: false, message: "Unauthorized. Access denied!!!");
  }
}

DioApiService apiService = DioApiService(AppInterceptors());
