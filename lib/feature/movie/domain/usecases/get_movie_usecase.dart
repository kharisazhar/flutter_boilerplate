import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/core/usecases/use_case.dart';
import 'package:flutter_boilerplate/feature/movie/data/model/movie_model.dart';
import 'package:flutter_boilerplate/feature/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/failures.dart';

class GetMovieUseCase implements UseCase<MovieModel, GetMovieParams> {
  final MovieRepository repository;

  GetMovieUseCase(this.repository);

  @override
  Future<Either<Failure, MovieModel>> call(GetMovieParams params) {
    return repository.getMovie(page: params.page);
  }
}

class GetMovieParams extends Equatable {
  final String page;

  const GetMovieParams({required this.page});

  @override
  List<Object?> get props => [page];
}
