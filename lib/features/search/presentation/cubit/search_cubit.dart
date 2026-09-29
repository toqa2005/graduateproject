import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;

  Timer? _debounce;

  SearchCubit(this.repository) : super(const SearchInitial());

  void search(String query) {
    final text = query.trim();

    _debounce?.cancel();

    if (text.isEmpty) {
      emit(const SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchMovies(text);
    });
  }

  Future<void> searchMovies(String query) async {
    final text = query.trim();

    if (text.isEmpty) {
      emit(const SearchInitial());
      return;
    }

    emit(const SearchLoading());

    try {
      final movies = await repository.searchMovies(query: text);

      if (movies.isEmpty) {
        emit(SearchEmpty(query: text));
        return;
      }

      emit(SearchSuccess(movies: movies, query: text));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
