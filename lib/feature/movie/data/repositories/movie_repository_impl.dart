import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import 'package:flutter_boilerplate/feature/movie/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_boilerplate/feature/movie/data/model/movie_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, MovieModel>> getMovie({required String page}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovie = await remoteDataSource.getMovie(page: page);
        return Right(remoteMovie);
      } catch (ex) {
        return Left(mapFailureException(ex));
      }
    }
    return Left(NetworkFailure());
  }
}
