import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate/feature/movie/data/model/movie_model.dart';

import '../../../../core/error/failures.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieModel>> getMovie({required String page});
}