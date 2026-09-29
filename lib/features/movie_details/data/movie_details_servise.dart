import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:graduateproject/features/home/data/movie_model.dart';

import 'movie_details_model.dart';

class MovieDetailsService {
  static const String baseUrl = 'https://yts.gg/api/v2';
  static const Duration _timeout = Duration(seconds: 15);

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final uri = Uri.parse('$baseUrl/movie_details.json').replace(
      queryParameters: {
        'movie_id': movieId.toString(),
        'with_images': 'true',
        'with_cast': 'true',
      },
    );

    final response = await http.get(uri).timeout(_timeout);
    final json = _decodeResponse(response);

    if (response.statusCode != 200) {
      throw Exception(
        json['status_message'] ??
            'Failed to load movie details: ${response.statusCode}',
      );
    }

    if (json['status'] != 'ok') {
      throw Exception(json['status_message'] ?? 'Failed to load movie details');
    }

    final data = json['data'];

    if (data is! Map) {
      throw Exception('Invalid movie details response');
    }

    return MovieDetailsModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<List<Movies>> getSuggestions(int movieId) async {
    final uri = Uri.parse(
      '$baseUrl/movie_suggestions.json',
    ).replace(queryParameters: {'movie_id': movieId.toString()});

    final response = await http.get(uri).timeout(_timeout);
    final json = _decodeResponse(response);

    if (response.statusCode != 200) {
      throw Exception(
        json['status_message'] ??
            'Failed to load movie suggestions: ${response.statusCode}',
      );
    }

    if (json['status'] != 'ok') {
      throw Exception(
        json['status_message'] ?? 'Failed to load movie suggestions',
      );
    }

    final data = json['data'];

    if (data is! Map) {
      return <Movies>[];
    }

    final movies = data['movies'];

    if (movies is! List) {
      return <Movies>[];
    }

    return movies
        .whereType<Map>()
        .map((item) => Movies.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }

      throw Exception('Invalid API response format');
    } on FormatException {
      throw Exception('Invalid JSON response from YTS API');
    }
  }
}
