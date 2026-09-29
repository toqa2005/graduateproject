import 'dart:convert';

import 'package:http/http.dart' as http;

import 'movie_model.dart';

class MovieService {
  static const String baseUrl = 'https://yts.gg/api/v2';
  static const Duration _timeout = Duration(seconds: 15);

  Future<MovieModel> getMovies({
    int page = 1,
    int limit = 50,
    String? genre,
  }) async {
    final query = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };

    if (genre != null && genre.trim().isNotEmpty) {
      query['genre'] = genre.trim();
    }

    final uri = Uri.parse(
      '$baseUrl/list_movies.json',
    ).replace(queryParameters: query);

    final response = await http.get(uri).timeout(_timeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }

    try {
      final decoded = jsonDecode(response.body);

      if (decoded is! Map) {
        throw Exception('Invalid movies response format');
      }

      final json = Map<String, dynamic>.from(decoded);

      if (json['status'] != 'ok') {
        throw Exception(json['status_message'] ?? 'Failed to load movies');
      }

      return MovieModel.fromJson(json);
    } on FormatException {
      throw Exception('Invalid JSON response from YTS API');
    }
  }
}
