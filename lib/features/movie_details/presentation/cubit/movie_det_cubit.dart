import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/features/profile_screen/data/profile_repo.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';

import '../../data/movie_details_servise.dart';
import 'movie_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsService service;
  final ProfileRepository profileRepository;

  MovieDetailsCubit(this.service, {ProfileRepository? profileRepository})
    : profileRepository = profileRepository ?? ProfileRepository(),
      super(MovieDetailsInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());

    try {
      final details = await service.getMovieDetails(movieId);
      final movie = details.movie;

      List<Movies> suggestions = [];

      try {
        suggestions = await service.getSuggestions(movieId);
      } catch (_) {}

      bool isInWatchList = false;

      if (movie.id != null && profileRepository.currentUser != null) {
        isInWatchList = await profileRepository.isInWatchList(movie.id!);
      }

      emit(
        MovieDetailsSuccess(
          movieDetails: details,
          suggestions: suggestions,
          isInWatchList: isInWatchList,
        ),
      );
      if (movie.id != null && profileRepository.currentUser != null) {
        try {
          await profileRepository.addToHistory(movie);
        } catch (_) {
        
        }
      }
    } catch (e) {
      emit(MovieDetailsFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> addCurrentMovieToHistory() async {
    final current = state;

    if (current is! MovieDetailsSuccess) return;

    final movie = current.movieDetails.movie;

    if (movie.id == null || profileRepository.currentUser == null) {
      return;
    }

    await profileRepository.addToHistory(movie);
  }

  Future<void> toggleWatchList() async {
    final current = state;

    if (current is! MovieDetailsSuccess) return;

    final movie = current.movieDetails.movie;

    if (movie.id == null || profileRepository.currentUser == null) {
      return;
    }

    try {
      if (current.isInWatchList) {
        await profileRepository.removeFromWatchList(movie.id!);
      } else {
        await profileRepository.addToWatchList(movie);
      }

      emit(current.copyWith(isInWatchList: !current.isInWatchList));
    } catch (e) {
      emit(MovieDetailsFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
