import 'package:graduateproject/features/home/data/movie_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchSuccess extends SearchState {
  final List<Movies> movies;
  final String query;

  const SearchSuccess({required this.movies, required this.query});
}

class SearchEmpty extends SearchState {
  final String query;

  const SearchEmpty({required this.query});
}

class SearchFailure extends SearchState {
  final String message;

  const SearchFailure(this.message);
}
