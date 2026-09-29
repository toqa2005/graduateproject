import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';

import '../../data/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(const ProfileInitial());

  Future<void> loadProfile() async {
    emit(const ProfileLoading());

    try {
      final user = repository.currentUser;

      if (user == null) {
        emit(const ProfileFailure('No logged-in user found.'));
        return;
      }

      debugPrint('===== PROFILE =====');
      debugPrint('UID: ${user.uid}');
      debugPrint('EMAIL: ${user.email}');

      final profile = await repository.getUserProfile();
      final userName = profile['name'] as String? ?? 'User';
      final avatarAsset = profile['avatarAsset'] as String?;
      final customAvatarBase64 = profile['customAvatarBase64'] as String?;

      debugPrint('NAME: $userName');

      final watchList = await repository.getWatchList();

      debugPrint('WATCHLIST COUNT: ${watchList.length}');

      final history = await repository.getHistory();

      debugPrint('HISTORY COUNT: ${history.length}');

      emit(
        ProfileLoaded(
          userName: userName,
          watchList: watchList,
          history: history,
          avatarAsset: avatarAsset,
          customAvatarBase64: customAvatarBase64,
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('===== PROFILE ERROR =====');
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());

      emit(ProfileFailure('Failed to load profile:\n$e'));
    }
  }

  void selectTab(int index) {
    final current = state;

    if (current is ProfileLoaded) {
      emit(current.copyWith(selectedTab: index));
    }
  }

  Future<void> addToWatchList(Movies movie) async {
    try {
      await repository.addToWatchList(movie);

      final current = state;

      if (current is ProfileLoaded) {
        final list = [...current.watchList];

        list.removeWhere((item) => item.id == movie.id);

        list.insert(0, movie);

        emit(current.copyWith(watchList: list));
      }
    } catch (e) {
      emit(ProfileFailure('Failed to add movie: $e'));
    }
  }

  Future<void> removeFromWatchList(int movieId) async {
    try {
      await repository.removeFromWatchList(movieId);

      final current = state;

      if (current is ProfileLoaded) {
        final list = current.watchList
            .where((movie) => movie.id != movieId)
            .toList();

        emit(current.copyWith(watchList: list));
      }
    } catch (e) {
      emit(ProfileFailure('Failed to remove movie: $e'));
    }
  }

  Future<void> addToHistory(Movies movie) async {
    try {
      await repository.addToHistory(movie);

      final current = state;

      if (current is ProfileLoaded) {
        final list = [...current.history];

        list.removeWhere((item) => item.id == movie.id);

        list.insert(0, movie);

        emit(current.copyWith(history: list));
      }
    } catch (e) {
      emit(ProfileFailure('Failed to save history: $e'));
    }
  }

  Future<void> logout() async {
    try {
      await repository.logout();
    } catch (e) {
      emit(ProfileFailure('Failed to logout: $e'));

      rethrow;
    }
  }

  Future<void> clearHistory() async {
    try {
      await repository.clearHistory();

      final current = state;

      if (current is ProfileLoaded) {
        emit(current.copyWith(history: const []));
      }
    } catch (e) {
      emit(ProfileFailure('Failed to clear history: $e'));
    }
  }
}
