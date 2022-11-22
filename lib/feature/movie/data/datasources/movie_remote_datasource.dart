import 'dart:convert';

import 'package:flutter_boilerplate/core/network/endpoint.dart';
import 'package:flutter_boilerplate/feature/movie/data/model/movie_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network/network_services.dart';

abstract class MovieRemoteDataSource {
  Future<MovieModel> getMovie({required String page});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  final NetworkServices networkServices;

  MovieRemoteDataSourceImpl(
      {required this.client, required this.networkServices});

  @override
  Future<MovieModel> getMovie({required String page}) async {
    try {
      final response = await networkServices.clientGet(
          endpoint: Endpoint.getMovie, client: client, params: 'page=$page');
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (ex) {
      rethrow;
    }
  }
}
