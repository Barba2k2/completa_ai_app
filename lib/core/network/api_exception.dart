import 'package:dio/dio.dart';

import 'bad_request_exception.dart';
import 'conflict_exception.dart';
import 'forbidden_exception.dart';
import 'network_exception.dart';
import 'not_found_exception.dart';
import 'request_cancelled_exception.dart';
import 'server_exception.dart';
import 'timeout_exception.dart';
import 'too_many_requests_exception.dart';
import 'unauthorized_exception.dart';
import 'unknown_exception.dart';
import 'validation_exception.dart';

abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  factory ApiException.fromDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        TimeoutException(message: exception.message ?? 'Request timed out'),
      DioExceptionType.connectionError => NetworkException(
          message: exception.message ?? 'No internet connection',
        ),
      DioExceptionType.badResponse => _handleBadResponse(exception.response),
      DioExceptionType.cancel => RequestCancelledException(),
      _ => UnknownException(message: exception.message ?? 'Unknown error'),
    };
  }

  static ApiException _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode ?? 0;
    final data = response?.data;
    final message = _extractMessage(data) ?? 'Server error';

    return switch (statusCode) {
      400 => BadRequestException(message: message, data: data),
      401 => UnauthorizedException(message: message),
      403 => ForbiddenException(message: message),
      404 => NotFoundException(message: message),
      409 => ConflictException(message: message, data: data),
      422 => ValidationException(message: message, data: data),
      429 => TooManyRequestsException(message: message),
      >= 500 => ServerException(message: message, statusCode: statusCode),
      _ => UnknownException(
          message: message,
          statusCode: statusCode,
          data: data,
        ),
    };
  }

  static String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is String) return data;
    if (data is Map) {
      return data['message'] as String? ??
          data['error'] as String? ??
          data['detail'] as String?;
    }
    return null;
  }

  @override
  String toString() => 'ApiException: $message (statusCode: $statusCode)';
}
