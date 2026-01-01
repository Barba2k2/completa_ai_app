import 'dart:developer';

import 'package:dio/dio.dart';

import '../../shared/services/firebase_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final user = FirebaseService.currentUser;

    if (user != null) {
      try {
        final token = await user.getIdToken();
        options.headers['Authorization'] = 'Bearer $token';
      } catch (e) {
        log('[AuthInterceptor] Failed to get token: $e');
      }
    }

    handler.next(options);
  }
}
