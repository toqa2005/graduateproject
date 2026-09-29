import '../../data/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final MovieModel movieModel;
  final List<Movies> genreMovies;
  final bool genreLoading;

  HomeSuccess(
    this.movieModel, {
    this.genreMovies = const [],
    this.genreLoading = false,
  });

  HomeSuccess copyWith({
    MovieModel? movieModel,
    List<Movies>? genreMovies,
    bool? genreLoading,
  }) {
    return HomeSuccess(
      movieModel ?? this.movieModel,
      genreMovies: genreMovies ?? this.genreMovies,
      genreLoading: genreLoading ?? this.genreLoading,
    );
  }
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}
