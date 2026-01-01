import 'api_exception.dart';

final class BadRequestException extends ApiException {
  const BadRequestException({required super.message, super.data})
      : super(statusCode: 400);
}
