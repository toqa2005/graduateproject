import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'profile_empty.dart';
import 'profile_header.dart';
import 'profile_movie.dart';
import 'profile_tab.dart';

class ProfileContent extends StatelessWidget {
  final ProfileLoaded state;
  final VoidCallback onEditProfile;
  final VoidCallback onLogout;

  const ProfileContent({
    super.key,
    required this.state,
    required this.onEditProfile,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Column(
      children: [
        ProfileHeader(
          userName: state.userName,
          watchListCount: state.watchList.length,
          historyCount: state.history.length,
          avatarAsset: state.avatarAsset,
          customAvatarBase64: state.customAvatarBase64,
          onEdit: onEditProfile,
          onLogout: onLogout,
        ),

        const SizedBox(height: 15),

        ProfileTabs(
          selectedTab: state.selectedTab,
          onChanged: cubit.selectTab,
        ),

        const SizedBox(height: 10),

        Expanded(
          child: state.currentMovies.isEmpty
              ? ProfileEmpty(history: state.selectedTab == 1)
              : ProfileMovie(movies: state.currentMovies),
        ),
      ],
    );
  }
}
