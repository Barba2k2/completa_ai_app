import 'api_exception.dart';

final class NotFoundException extends ApiException {
  const NotFoundException({required super.message}) : super(statusCode: 404);
}
