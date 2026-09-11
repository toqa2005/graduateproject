class MovieModel {
  final int id;
  final String title;
  final String titleEnglish;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;

  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final String backgroundImage;

  MovieModel({
    required this.id,
    required this.title,
    required this.titleEnglish,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.backgroundImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,

      title: json['title'] ?? '',

      titleEnglish: json['title_english'] ?? '',

      year: json['year'] ?? 0,

      rating: (json['rating'] ?? 0).toDouble(),

      runtime: json['runtime'] ?? 0,

      genres: List<String>.from(
        json['genres'] ?? [],
      ),

      summary: json['summary'] ?? '',

      smallCoverImage:
      json['small_cover_image'] ?? '',

      mediumCoverImage:
      json['medium_cover_image'] ?? '',

      largeCoverImage:
      json['large_cover_image'] ?? '',

      backgroundImage:
      json['background_image'] ?? '',
    );
  }
}