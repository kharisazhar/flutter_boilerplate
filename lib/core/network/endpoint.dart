import 'package:flutter_boilerplate/core/network/api_key.dart';

class Endpoint {
  static const getMovie =
      'movie/now_playing?api_key=${ApiKey.movieApiKey}&language=en-US&';
}
