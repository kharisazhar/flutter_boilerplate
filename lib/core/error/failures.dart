import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final int code;
  final String message;

  ServerFailure({required this.code, required this.message});

  @override
  String toString() => "[$code] - $message";
}

class NetworkFailure extends Failure {
  @override
  String toString() => 'Oops';
}

String mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure) {
    return failure.toString();
  } else if (failure is NetworkFailure) {
    return failure.toString();
  } else {
    return 'Unknown Error';
  }
}
