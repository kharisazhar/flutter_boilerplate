import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_event.dart';
import 'package:flutter_boilerplate/feature/movie/presentation/bloc/movie/movie_state.dart';

import '../../../../core/di/injection_container.dart';

class MovieHomeScreen extends StatelessWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: BlocBuilder<MovieBloc, MovieState>(
          bloc: sl<MovieBloc>()..add(GetMovieEvent()),
          builder: (context, state) {
            if (state is EmptyMovieState) {
              return Container();
            } else if (state is LoadingMovieState) {
              return const CircularProgressIndicator();
            } else if (state is ErrorMovieState) {
              return Text('Oops ${state.message}');
            } else if (state is LoadedMovieState) {
              return ListView.builder(
                  itemCount: state.movieResponse.results.length,
                  itemBuilder: (context, index) {
                    var data = state.movieResponse.results[index];
                    return ListTile(
                        title: Text(data.title), subtitle: Text(data.overview));
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
