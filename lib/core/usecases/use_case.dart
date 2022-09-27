import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/base_failure.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class BaseUseCase<Type, Params> {
  Future<Either<BaseFailure, Type>> call(Params params);
}

/// NO PARAMS DATA
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
