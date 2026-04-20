import 'api_exception.dart';

final class ServerException extends ApiException {
  const ServerException({required super.message, required super.statusCode});
}
