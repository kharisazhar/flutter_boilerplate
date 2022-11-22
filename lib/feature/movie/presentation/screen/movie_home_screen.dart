import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature/movie/domain/usecases/get_movie_usecase.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_event.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_state.dart';

import '../../../../core/di/injection_container.dart';

class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  late final MovieBloc _movieBloc;

  final _scrollController = ScrollController();
  int _pageCount = 1;

  @override
  void initState() {
    super.initState();

    _movieBloc = MovieBloc(useCase: sl<GetMovieUseCase>());

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _pageCount++;

      _movieBloc.add(GetMovieEvent(page: '$_pageCount'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: BlocBuilder<MovieBloc, MovieState>(
          bloc: _movieBloc..add(GetMovieEvent(page: '$_pageCount')),
          builder: (context, state) {
            if (state is EmptyMovieState) {
              return Container();
            } else if (state is LoadingMovieState) {
              return const CircularProgressIndicator();
            } else if (state is ErrorMovieState) {
              return Text('Oops ${state.message}');
            } else if (state is LoadedMovieState) {
              var itemCount = (state.hasReachedMax ?? false)
                  ? state.movieResults.length
                  : state.movieResults.length + 1;
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: itemCount,
                  // itemCount: state.movieResults.length,
                  itemBuilder: (context, index) {
                    return index >= state.movieResults.length
                        ? const SizedBox(
                            height: 32,
                            width: 32,
                            child: CircularProgressIndicator())
                        : ListTile(
                            title: Text(state.movieResults[index].title),
                            subtitle: Text(state.movieResults[index].overview));
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
