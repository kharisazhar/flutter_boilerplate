import 'base_failure.dart';
import 'failures.dart';

class ServerException implements Exception {
  final String message;

  /// TODO : Create your own default error
  ServerException({this.message = "Oops.."});

  @override
  String toString() => message;
}

class ErrorRequestException implements Exception {
  final BaseFailure failure;

  ErrorRequestException(this.failure);
}

class NetworkException implements Exception {}

Failure mapFailureException(dynamic ex) {
  if (ex is NetworkException) {
    return NetworkFailure();
  } else if (ex is ServerException) {
    return ServerFailure(message: ex.toString(), code: 0);
  } else {
    return ServerFailure(code: 0, message: 'Oops');
  }
}
