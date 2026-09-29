import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/core/routes/routsapp.dart';

import '../../data/profile_repo.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../customs/profile_content.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => ProfilescreenState();
}

class ProfilescreenState extends State<Profilescreen> {
  late final ProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ProfileCubit(ProfileRepository())..loadProfile();
  }

  Future<void> refresh() async {
    await cubit.loadProfile();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: cubit, child: const _ProfileView());
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  Future<void> _logout(BuildContext context) async {
    try {
      await context.read<ProfileCubit>().logout();

      if (!context.mounted) return;

      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(Routes.loginscreen, (route) => false);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
    }
  }

  Future<void> _editProfile(BuildContext context) async {
    await Navigator.pushNamed(context, Routes.updatescreen);

    if (context.mounted) {
      context.read<ProfileCubit>().loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,

      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },

          builder: (context, state) {
            if (state is ProfileInitial || state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Appcolor.yellow,
                  strokeWidth: 2,
                ),
              );
            }

            if (state is ProfileLoaded) {
              return ProfileContent(
                state: state,

                onEditProfile: () {
                  _editProfile(context);
                },

                onLogout: () {
                  _logout(context);
                },
              );
            }

            if (state is ProfileFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Appcolor.red,
                        size: 55,
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'Unable to load profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Appcolor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<ProfileCubit>().loadProfile();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
