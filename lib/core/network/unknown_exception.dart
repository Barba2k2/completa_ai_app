import 'api_exception.dart';

final class UnknownException extends ApiException {
  const UnknownException({
    required super.message,
    super.statusCode,
    super.data,
  });
}
