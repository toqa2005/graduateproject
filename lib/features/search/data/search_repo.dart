import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:graduateproject/features/home/data/movie_model.dart';

class SearchRepository {
  static const String _baseUrl = 'https://yts.gg/api/v2/list_movies.json';

  Future<List<Movies>> searchMovies({required String query}) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'query_term': query,
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
      throw Exception('Failed to search movies: ${response.statusCode}');
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
}
