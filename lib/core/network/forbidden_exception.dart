import 'api_exception.dart';

final class ForbiddenException extends ApiException {
  const ForbiddenException({required super.message}) : super(statusCode: 403);
}
