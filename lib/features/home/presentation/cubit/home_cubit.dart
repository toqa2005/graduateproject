import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/movie_service.dart';
import '../../../browser/data/browse_repo.dart';
import '../../data/movie_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieService movieService;
  final BrowseRepository browseRepository;

  HomeCubit(this.movieService, {BrowseRepository? browseRepository})
    : browseRepository = browseRepository ?? BrowseRepository(),
      super(HomeInitial());

  Future<void> initialize({String genre = 'Action'}) async {
    await getMovies(page: 1, limit: 50);
    if (state is HomeSuccess) {
      await getGenreMovies(genre);
    }
  }

  Future<void> getMovies({int page = 1, int limit = 50, String? genre}) async {
    if (state is HomeLoading) return;

    emit(HomeLoading());

    try {
      final result = await movieService.getMovies(
        page: page,
        limit: limit,
        genre: genre,
      );

      emit(HomeSuccess(result));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> getGenreMovies(String genre) async {
    final currentState = state;
    if (currentState is! HomeSuccess) return;

    emit(currentState.copyWith(genreLoading: true));

    try {
      final movies = await browseRepository.getMoviesByGenre(genre: genre);

      if (state is HomeSuccess) {
        emit(
          (state as HomeSuccess).copyWith(
            genreMovies: movies,
            genreLoading: false,
          ),
        );
      }
    } catch (_) {
      if (state is HomeSuccess) {
        emit((state as HomeSuccess).copyWith(genreLoading: false));
      }
    }
  }
}
