import 'api_exception.dart';

final class TooManyRequestsException extends ApiException {
  const TooManyRequestsException({required super.message})
      : super(statusCode: 429);
}
