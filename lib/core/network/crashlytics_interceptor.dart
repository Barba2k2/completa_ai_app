import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    FirebaseCrashlytics.instance.recordError(
      err,
      err.stackTrace,
      reason: 'API Error: ${err.requestOptions.method} ${err.requestOptions.path}',
      information: [
        'URL: ${err.requestOptions.uri}',
        'Status: ${err.response?.statusCode}',
        'Message: ${err.message}',
      ],
    );

    handler.next(err);
  }
}
