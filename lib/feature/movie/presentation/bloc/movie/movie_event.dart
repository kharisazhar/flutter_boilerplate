import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMovieEvent extends MovieEvent {
  final String page;

  GetMovieEvent({required this.page});
}

/// in case need params
// class GetMovieDetailEvent extends MovieEvent {
//   final String movieId;
//
//   GetMovieDetailEvent({required this.movieId});
// }
