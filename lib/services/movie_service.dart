import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/responce.dart';
class MovieService {

  final String baseUrl =
      'https://movies-api.accel.li/api/v2';

  Future<MoviesResponseModel> getMovies() async {

    final Uri url = Uri.parse(
      '$baseUrl/list_movies.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {

      final Map<String, dynamic> json =
      jsonDecode(response.body);

      return MoviesResponseModel.fromJson(json);

    } else {
      throw Exception(
        'Failed to load movies',
      );
    }
  }
}