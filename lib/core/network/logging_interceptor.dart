import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      log('[API] --> ${options.method} ${options.uri}');
      if (options.data != null) {
        log('[API] Body: ${options.data}');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      log('[API] <-- ${response.statusCode} ${response.requestOptions.uri}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log('[API] <-- ERROR ${err.response?.statusCode} ${err.requestOptions.uri}');
      log('[API] Error: ${err.message}');
    }
    handler.next(err);
  }
}
