import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:graduateproject/features/home/data/movie_model.dart';

class BrowseRepository {
  static const String _baseUrl = 'https://yts.gg/api/v2/list_movies.json';

  Future<List<Movies>> getMoviesByGenre({required String genre}) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'genre': genre,
        'limit': '50',
        'sort_by': 'date_added',
        'order_by': 'desc',
      },
    );

    final response = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    final data = json['data'];

    if (data == null) {
      throw Exception('Invalid response from YTS API');
    }

    final movieList = data['movies'];

    if (movieList == null) {
      return [];
    }

    if (movieList is! List) {
      throw Exception('Invalid movies data');
    }

    return movieList
        .map((movie) => Movies.fromJson(Map<String, dynamic>.from(movie)))
        .toList();
  }

  Future<List<String>> getGenres() async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'limit': '50',
        'sort_by': 'date_added',
        'order_by': 'desc',
      },
    );

    final response = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load genres: ${response.statusCode}');
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    final data = json['data'];

    if (data == null) {
      throw Exception('Invalid response from YTS API');
    }

    final movieList = data['movies'];

    if (movieList is! List) {
      return [];
    }

    final Set<String> genres = {};

    for (final movie in movieList) {
      if (movie is! Map) continue;

      final movieGenres = movie['genres'];

      if (movieGenres is List) {
        for (final genre in movieGenres) {
          if (genre is String && genre.trim().isNotEmpty) {
            genres.add(genre.trim());
          }
        }
      }
    }

    final result = genres.toList();

    result.sort();

    return result;
  }
}
