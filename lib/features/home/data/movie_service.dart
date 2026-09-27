import 'dart:convert';

import 'package:http/http.dart' as http;

import 'movie_model.dart';

class MovieService {
  final String baseUrl =
      'https://movies-api.accel.li/api/v2';

  Future<MovieModel> getMovies() async {
    final Uri url = Uri.parse(
      '$baseUrl/list_movies.json',
    );

    final response = await http
        .get(url)
        .timeout(
      const Duration(seconds: 15),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
      jsonDecode(response.body);

      return MovieModel.fromJson(json);
    }

    throw Exception(
      'Failed to load movies: ${response.statusCode}',
    );
  }
}