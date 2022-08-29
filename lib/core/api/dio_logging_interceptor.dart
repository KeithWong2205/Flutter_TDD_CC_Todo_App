import 'package:flutter_tcc_base_source/core/di/injection_container.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_logger.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';
import 'package:dio/dio.dart';

class DioLoggingInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    addToken(options);
    logRequest(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logError(err);
    super.onError(err, handler);
  }

  String getErrorMessage(DioError dioError) {
    String errorDescription = 'Unexpected error occured';
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorDescription = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        errorDescription = 'Connection timeout with API server';
        break;
      case DioErrorType.other:
        errorDescription = 'Connection to API server failed due to internet connection';
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = 'Receive timeout in connection with API server';
        break;
      case DioErrorType.response:
        if (dioError.response!.data['Error'] != null) {
          errorDescription = dioError.response!.data['Error']['Message'];
        } else {
          errorDescription = 'Received invalid status code: ${dioError.response!.statusCode}';
        }
        break;
      case DioErrorType.sendTimeout:
        errorDescription = 'Send timeout in connection with API server';
        break;
    }
    return errorDescription;
  }

  void logRequest(RequestOptions options) {
    var buffer = StringBuffer();
    buffer.write('--> ${options.method.toUpperCase()} ${'' + (options.baseUrl) + (options.path)}');
    buffer.write('\nHeaders:');
    options.headers.forEach((k, v) => buffer.write(' $k: $v;'));

    buffer.write('\nParameters:');
    options.queryParameters.forEach((k, v) => buffer.write(' $k: $v;'));

    if (options.data != null) {
      buffer.write('\nBody: ${options.data}');
    }
    buffer.write('\n--> END ${options.method.toUpperCase()}');
    AppLogger.log(buffer.toString());
  }

  void logResponse(Response response) {
    var buffer = StringBuffer();
    buffer.write('<-- ${response.statusCode} ${(response.realUri)}');
    buffer.write('\nResponse: ${response.data}');
    AppLogger.log(buffer.toString());
  }

  void logError(DioError dioError) {
    var buffer = StringBuffer();
    buffer.write('<-- ${dioError.message} ${(dioError.response != null ? dioError.response!.realUri : 'URL')}');
    buffer.write('\n${dioError.response != null ? dioError.response!.data : 'Unknown Error'}');
    AppLogger.log(buffer.toString());
    String errorMessage = getErrorMessage(dioError);
    if (dioError.type != DioErrorType.response) {
      AppUtils.showToastMessage(errorMessage);
    }
    if (dioError.type == DioErrorType.response &&
        dioError.response!.statusCode == 401 &&
        dioError.response!.realUri.toString().contains('RefreshToken')) {
      AppUtils.showToastMessage(errorMessage);
    }
    if (dioError.type == DioErrorType.response && dioError.response!.statusCode != 200) {
      // showToastMessage(errorMessage);
    }
  }

  void addToken(RequestOptions options) async {
    String token = await sl<SecureStorage>().getCustomString(SecureStorage.apiToken);
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
