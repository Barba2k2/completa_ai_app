import 'api_exception.dart';

final class UnauthorizedException extends ApiException {
  const UnauthorizedException({required super.message}) : super(statusCode: 401);
}
