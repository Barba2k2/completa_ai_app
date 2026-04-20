import 'api_exception.dart';

final class ConflictException extends ApiException {
  const ConflictException({required super.message, super.data})
      : super(statusCode: 409);
}
