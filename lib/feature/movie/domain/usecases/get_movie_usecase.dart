import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/core/usecases/use_case.dart';
import 'package:flutter_boilerplate/feature/movie/data/model/movie_model.dart';
import 'package:flutter_boilerplate/feature/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/failures.dart';

class GetMovieUseCase implements UseCase<MovieModel, NoParams> {
  final MovieRepository repository;

  GetMovieUseCase(this.repository);

  @override
  Future<Either<Failure, MovieModel>> call(NoParams params) {
    return repository.getMovie();
  }
}

class ExampleParams extends Equatable {
  final String movieID;

  const ExampleParams({required this.movieID});

  @override
  List<Object?> get props => [movieID];
}
