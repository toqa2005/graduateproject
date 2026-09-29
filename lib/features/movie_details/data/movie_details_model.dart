import 'package:graduateproject/features/home/data/movie_model.dart';

class MovieDetailsModel {
  final Movies movie;
  final List<String> screenshots;

  const MovieDetailsModel({required this.movie, required this.screenshots});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final movieJson = Map<String, dynamic>.from(json['movie'] ?? {});

    final screenshots = <String>[
      if (movieJson['medium_screenshot_image1'] != null)
        movieJson['medium_screenshot_image1'].toString(),

      if (movieJson['medium_screenshot_image2'] != null)
        movieJson['medium_screenshot_image2'].toString(),

      if (movieJson['medium_screenshot_image3'] != null)
        movieJson['medium_screenshot_image3'].toString(),
    ];

    return MovieDetailsModel(
      movie: Movies.fromJson(movieJson),
      screenshots: screenshots,
    );
  }
}
