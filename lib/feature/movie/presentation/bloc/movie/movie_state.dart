import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/movie/data/model/movie_model.dart';

@immutable
abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmptyMovieState extends MovieState {}

class LoadingMovieState extends MovieState {}

class LoadedMovieState extends MovieState {
  final bool? hasReachedMax;
  final List<MovieResult> movieResults;
  final int? totalPage;

  LoadedMovieState copyWith({
    bool? hasReachedMax,
    List<MovieResult>? movieResults,
    int? totalPage,
  }) {
    return LoadedMovieState(
        movieResults: movieResults ?? this.movieResults,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        totalPage: totalPage ?? this.totalPage);
  }

  LoadedMovieState(
      {required this.movieResults,
      this.hasReachedMax,
      required this.totalPage});

  @override
  List<Object?> get props => [movieResults, hasReachedMax, totalPage];
}

class ErrorMovieState extends MovieState {
  final String message;

  ErrorMovieState({required this.message});
}
