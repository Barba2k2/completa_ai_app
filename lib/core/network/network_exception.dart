import 'api_exception.dart';

final class NetworkException extends ApiException {
  const NetworkException({required super.message}) : super(statusCode: null);
}
