import 'api_exception.dart';

final class ValidationException extends ApiException {
  const ValidationException({required super.message, super.data})
      : super(statusCode: 422);
}
