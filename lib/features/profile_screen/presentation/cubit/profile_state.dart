import 'package:graduateproject/features/home/data/movie_model.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final String userName;
  final List<Movies> watchList;
  final List<Movies> history;
  final int selectedTab;
  final String? avatarAsset;
  final String? customAvatarBase64;

  const ProfileLoaded({
    required this.userName,
    required this.watchList,
    required this.history,
    this.selectedTab = 0,
    this.avatarAsset,
    this.customAvatarBase64,
  });

  List<Movies> get currentMovies => selectedTab == 0 ? watchList : history;

  ProfileLoaded copyWith({
    String? userName,
    List<Movies>? watchList,
    List<Movies>? history,
    int? selectedTab,
    String? avatarAsset,
    String? customAvatarBase64,
    bool clearCustomAvatar = false,
  }) {
    return ProfileLoaded(
      userName: userName ?? this.userName,
      watchList: watchList ?? this.watchList,
      history: history ?? this.history,
      selectedTab: selectedTab ?? this.selectedTab,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      customAvatarBase64: clearCustomAvatar
          ? null
          : customAvatarBase64 ?? this.customAvatarBase64,
    );
  }
}

class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure(this.message);
}
