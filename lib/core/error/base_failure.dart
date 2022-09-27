import 'package:equatable/equatable.dart';

/// Basically Just Created default json response from BE
class BaseFailure extends Equatable {
  const BaseFailure(
      {required this.status, required this.code, required this.message});

  final int status;
  final int code;
  final String message;

  factory BaseFailure.fromJson(Map<String, dynamic> json) => BaseFailure(
      status: json['status'], code: json['code'], message: json['message']);

  Map<String, dynamic> toJson() =>
      {'status': status, 'code': code, 'message': message};

  @override
  List<Object> get props => [status, code, message];
}
