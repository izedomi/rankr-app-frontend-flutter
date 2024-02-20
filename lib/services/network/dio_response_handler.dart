import 'package:dio/dio.dart';
import '../../app/constants/app_text.dart';
import '../../app/models/api_response.dart';
import '../../app/print.dart';

class DioResponseHandler {
  static ApiResponse parseResponse(Response res) {
    printty("Response Code: ${res.statusCode}");
    printty("Response Body: ${res.data}");

    try {
      late dynamic response = res.data;

      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202) {
        try {
          String? msg = "";
          printty(response.runtimeType.toString());

          if (response.runtimeType.toString() == "List<dynamic>") {
            msg = "";
          } else {
            msg = response["message"]?.toString() ?? "";
          }

          return ApiResponse(
              code: res.statusCode,
              success: true,
              message: msg,
              data: response ?? "Success",
              raw: res);
        } catch (e, s) {
          printty(e.toString());
          printty(s.toString());
          return ApiResponse(
              code: res.statusCode,
              success: false,
              message: e.toString(),
              raw: res);
        }
      } else if (res.statusCode == 404) {
        return ApiResponse(
            code: res.statusCode,
            success: false,
            message: AppText.errorMsg,
            raw: res);
        // return _parseBadRequestError(response);
      } else if (res.statusCode == 422) {
        return ApiResponse(
            code: res.statusCode,
            success: false,
            message: response["message"] ?? AppText.errorMsg,
            raw: res);
        // return _parseBadRequestError(response);
      } else if (res.statusCode! >= 400 || res.statusCode! <= 404) {
        return ApiResponse(
            code: res.statusCode,
            success: false,
            message: response["message"] ?? AppText.errorMsg,
            raw: res);
      } else {
        return ApiResponse(
            code: res.statusCode,
            success: false,
            message: response["message"],
            raw: res);
      }
    } catch (e) {
      return ApiResponse(
          code: res.statusCode,
          success: false,
          message: AppText.errorMsg,
          raw: res);
    }
  }

  static ApiResponse dioErrorHandler(DioException e) {
    final dioError = e;

    switch (dioError.type) {
      case DioExceptionType.badResponse:
        printty("error code: ${dioError.response!.statusCode}");
        printty("error data: ${dioError.response!.data}");

        try {
          if (dioError.response?.statusCode == 404) {
            return ApiResponse(
                code: 404,
                success: false,
                message: AppText.errorMsg,
                raw: dioError.response);
          }

          if (dioError.response!.data["message"] is List) {
            return _parseBadRequestError(dioError.response);
          }

          // printty(dioError.response!.data["message"]);

          final errMsg = dioError.response!.data["message"] ??
              dioError.message ??
              dioError.response?.statusMessage ??
              AppText.errorMsg;

          return ApiResponse(
              code: dioError.response?.statusCode,
              success: false,
              message: errMsg.toLowerCase().contains("service can't be reached")
                  ? AppText.errorMsg
                  : errMsg,
              raw: dioError.response);
        } catch (e) {
          return ApiResponse(
              code: dioError.response!.statusCode,
              success: false,
              message: AppText.errorMsg,
              raw: dioError.response);
        }

      case DioExceptionType.cancel:
        printty("1");
        return ApiResponse(
            code: 500,
            success: false,
            message: AppText.errorMsg,
            raw: dioError.response);
      case DioExceptionType.connectionTimeout:
        printty("2");
        return ApiResponse(
            code: 500,
            success: false,
            message: "Connection Timed Out",
            raw: dioError.response);
      case DioExceptionType.unknown:
        printty("3");
        return ApiResponse(
            code: 500,
            success: false,
            message: AppText.errorMsg,
            raw: dioError.response);
      case DioExceptionType.sendTimeout:
        printty("4");
        return ApiResponse(
            code: 500,
            success: false,
            message: "Sender Connection Timed Out",
            raw: dioError.response);
      case DioExceptionType.receiveTimeout:
        printty("5");
        return ApiResponse(
            code: 500,
            success: false,
            message: "Reciever Connection Timed Out",
            raw: dioError.response);
      default:
        return ApiResponse(
            code: 500,
            success: false,
            message: AppText.errorMsg,
            raw: dioError.response);
    }
  }

  static ApiResponse _parseBadRequestError(dynamic response) {
    String? error;
    try {
      if (response.data["message"] != null) {
        //error = response.data["message"][0];
        for (var v in response.data["message"]) {
          if (error == null || error.isEmpty) {
            error = "$v";
          } else {
            error += "\n$v";
          }
        }
      }
    } catch (e) {
      error = e.toString();
    }
    return ApiResponse(
        success: false, message: error ?? response["message"], raw: response);
  }
}
