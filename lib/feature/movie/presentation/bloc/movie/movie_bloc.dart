import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/usecases/use_case.dart';
import 'package:flutter_boilerplate/feature/movie/data/model/movie_model.dart';
import 'package:flutter_boilerplate/feature/movie/domain/usecases/get_movie_usecase.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_event.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_state.dart';

import '../../../../../core/error/failures.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieUseCase useCase;

  MovieBloc({required this.useCase}) : super(EmptyMovieState()) {
    on<GetMovieEvent>(_onGetMovieEvent);
  }

  void _onGetMovieEvent(MovieEvent event, Emitter<MovieState> emit) async {
    emit(LoadingMovieState());
    final failureOrGetMovie = await useCase.call(NoParams());
    _eitherLoadedOrError(failureOrGetMovie, emit);
  }

  void _eitherLoadedOrError(
      Either<Failure, MovieModel> failureOrSucceed, Emitter<MovieState> emit) {
    failureOrSucceed.fold(
      (failure) => emit(ErrorMovieState(
        message: mapFailureToMessage(failure),
      )),
      (response) => emit(LoadedMovieState(movieResponse: response)),
    );
  }
}
