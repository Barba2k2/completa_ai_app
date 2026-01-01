import 'api_exception.dart';

final class TimeoutException extends ApiException {
  const TimeoutException({required super.message}) : super(statusCode: null);
}
