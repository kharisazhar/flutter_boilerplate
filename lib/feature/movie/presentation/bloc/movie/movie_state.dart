import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/movie/data/model/movie_model.dart';

@immutable
abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyMovieState extends MovieState {}

class LoadingMovieState extends MovieState {}

class LoadedMovieState extends MovieState {
  final MovieModel movieResponse;

  LoadedMovieState({required this.movieResponse});
}

class ErrorMovieState extends MovieState {
  final String message;

  ErrorMovieState({required this.message});
}
