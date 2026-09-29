import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/gener_selection.dart';
import '../../data/browse_repo.dart';
import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final BrowseRepository repository;

  BrowseCubit(this.repository) : super(const BrowseInitial());

  Future<void> loadMovies({String genre = 'Action'}) async {
    GenreSelection.selected.value = genre;
    List<String> genres = [];

    if (state is BrowseSuccess) {
      genres = (state as BrowseSuccess).genres;
    } else if (state is BrowseLoading) {
      genres = (state as BrowseLoading).genres;
    } else if (state is BrowseFailure) {
      genres = (state as BrowseFailure).genres;
    }

    emit(BrowseLoading(genres: genres, selectedGenre: genre));

    try {
      final movies = await repository.getMoviesByGenre(genre: genre);
      if (genres.isEmpty) {
        genres = await repository.getGenres();
      }

      emit(BrowseSuccess(movies: movies, genres: genres, selectedGenre: genre));
    } catch (e) {
      emit(
        BrowseFailure(
          message: e.toString(),
          genres: genres,
          selectedGenre: genre,
        ),
      );
    }
  }

  Future<void> changeGenre(String genre) async {
    GenreSelection.selected.value = genre;
    if (state is BrowseSuccess) {
      final currentState = state as BrowseSuccess;

      if (currentState.selectedGenre == genre) {
        return;
      }
    }

    await loadMovies(genre: genre);
  }
}
