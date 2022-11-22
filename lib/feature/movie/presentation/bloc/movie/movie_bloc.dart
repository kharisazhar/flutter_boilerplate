import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void _onGetMovieEvent(GetMovieEvent event, Emitter<MovieState> emit) async {
    final currentState = state;
    if (!_hasReachedMax(currentState)) {
      if (currentState is EmptyMovieState) {
        emit(LoadingMovieState());
        final failureOrGetMovie =
            await useCase.call(const GetMovieParams(page: '1'));
        _eitherLoadedOrError(failureOrGetMovie, emit);
      }
      if (currentState is LoadedMovieState) {
        final failureOrGetMovie =
            await useCase.call(GetMovieParams(page: event.page));
        _eitherLoadedOrErrorGetMoviePagination(
            failureOrGetMovie, currentState, emit);
      }
    }
  }

  void _eitherLoadedOrError(
      Either<Failure, MovieModel> failureOrSucceed, Emitter<MovieState> emit) {
    failureOrSucceed.fold(
      (failure) => emit(ErrorMovieState(
        message: mapFailureToMessage(failure),
      )),
      (response) => emit(LoadedMovieState(
          movieResults: response.results,
          hasReachedMax: response.results.isEmpty ? true : false,
          totalPage: response.page)),
    );
  }

  void _eitherLoadedOrErrorGetMoviePagination(
      Either<Failure, MovieModel> failureOrSucceed,
      LoadedMovieState currentState,
      Emitter<MovieState> emit) {
    failureOrSucceed.fold(
      (failure) => emit(ErrorMovieState(
        message: mapFailureToMessage(failure),
      )),
      (response) => {
        response.results.isEmpty
            ? emit(currentState.copyWith(hasReachedMax: true))
            : emit(LoadedMovieState(
                movieResults: currentState.movieResults + response.results,
                hasReachedMax: false,
                totalPage: currentState.totalPage)),
      },
    );
  }

  bool _hasReachedMax(MovieState state) =>
      state is LoadedMovieState && (state.hasReachedMax ?? false);
}
