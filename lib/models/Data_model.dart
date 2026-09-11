import 'movie_model.dart';

class DataModel {
  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<MovieModel> movies;

  DataModel({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  factory DataModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return DataModel(
      movieCount: json['movie_count'] ?? 0,

      limit: json['limit'] ?? 0,

      pageNumber: json['page_number'] ?? 0,

      movies: (json['movies'] as List? ?? [])
          .map(
            (movie) => MovieModel.fromJson(movie),
      )
          .toList(),
    );
  }
}