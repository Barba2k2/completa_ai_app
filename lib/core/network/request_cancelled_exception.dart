import 'api_exception.dart';

final class RequestCancelledException extends ApiException {
  const RequestCancelledException()
      : super(message: 'Request cancelled', statusCode: null);
}
