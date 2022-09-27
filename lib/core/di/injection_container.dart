import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_boilerplate/feature/movie/data/repositories/movie_repository_impl.dart';
import 'package:flutter_boilerplate/feature/movie/domain/repositories/movie_repository.dart';
import 'package:flutter_boilerplate/feature/movie/domain/usecases/get_movie_usecase.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../feature/movie/data/datasources/movie_remote_datasource.dart';
import '../network/headers_config.dart';
import '../network/network_services.dart';
import '../platform/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// BLOC
  sl.registerFactory(() => MovieBloc(useCase: sl.call()));

  /// USECASE
  sl.registerLazySingleton(() => GetMovieUseCase(sl()));

  /// REPOSITORIES
  sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  /// DATA SOURCES
  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl(), networkServices: sl()));

  /// CORE
  sl.registerLazySingleton<HeadersConfig>(() => HeadersConfigImpl());
  sl.registerLazySingleton<NetworkServices>(
      () => NetworkServices(headersConfig: sl(), httpClient: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// EXTERNAL
  final httpClient = HttpClient();
  final Connectivity connectivity = Connectivity();

  sl.registerLazySingleton(() => httpClient);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => connectivity);
}
