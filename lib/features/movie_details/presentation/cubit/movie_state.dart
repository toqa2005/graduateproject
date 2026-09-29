import 'package:graduateproject/features/home/data/movie_model.dart';
import '../../data/movie_details_model.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel movieDetails;
  final List<Movies> suggestions;
  final bool isInWatchList;

  MovieDetailsSuccess({
    required this.movieDetails,
    required this.suggestions,
    required this.isInWatchList,
  });

  MovieDetailsSuccess copyWith({
    bool? isInWatchList,
    List<Movies>? suggestions,
  }) {
    return MovieDetailsSuccess(
      movieDetails: movieDetails,
      suggestions: suggestions ?? this.suggestions,
      isInWatchList: isInWatchList ?? this.isInWatchList,
    );
  }
}

class MovieDetailsFailure extends MovieDetailsState {
  final String message;

  MovieDetailsFailure(this.message);
}
