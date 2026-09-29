import 'package:graduateproject/features/home/data/movie_model.dart';

abstract class BrowseState {
  const BrowseState();
}

class BrowseInitial extends BrowseState {
  const BrowseInitial();
}

class BrowseLoading extends BrowseState {
  final List<String> genres;
  final String selectedGenre;

  const BrowseLoading({required this.genres, required this.selectedGenre});
}

class BrowseSuccess extends BrowseState {
  final List<Movies> movies;
  final List<String> genres;
  final String selectedGenre;

  const BrowseSuccess({
    required this.movies,
    required this.genres,
    required this.selectedGenre,
  });
}

class BrowseFailure extends BrowseState {
  final String message;
  final List<String> genres;
  final String selectedGenre;

  const BrowseFailure({
    required this.message,
    required this.genres,
    required this.selectedGenre,
  });
}
