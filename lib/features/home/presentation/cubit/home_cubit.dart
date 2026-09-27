import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/movie_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieService movieService;

  HomeCubit(this.movieService) : super(HomeInitial());

  Future<void> getMovies() async {
    if (state is HomeLoading) return;

    emit(HomeLoading());

    try {
      final result = await movieService.getMovies();

      emit(HomeSuccess(result));
    } catch (e) {
      emit(
        HomeFailure(
          e.toString(),
        ),
      );
    }
  }
}