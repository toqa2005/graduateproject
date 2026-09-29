import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/features/browser/presentation/cubit/browse_cubit.dart';
import 'package:graduateproject/features/browser/presentation/cubit/browse_state.dart';
import 'package:graduateproject/features/browser/presentation/customs/geners.dart';

import '../../data/browse_repo.dart';
import '../customs/browser_empty.dart';
import '../customs/browser_error.dart';
import '../customs/movies_browser.dart';

class Browser extends StatelessWidget {
  const Browser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BrowseCubit(BrowseRepository())..loadMovies(genre: 'Action'),
      child: const _BrowserView(),
    );
  }
}

class _BrowserView extends StatelessWidget {
  const _BrowserView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Column(
          children: [
            const Geners(),

            const SizedBox(height: 8),

            Expanded(
              child: BlocBuilder<BrowseCubit, BrowseState>(
                builder: (context, state) {
                  if (state is BrowseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Appcolor.yellow,
                        strokeWidth: 2,
                      ),
                    );
                  }

                  if (state is BrowseFailure) {
                    return BrowserError(
                      message: state.message,
                      onRetry: () {
                        context.read<BrowseCubit>().loadMovies(
                          genre: state.selectedGenre,
                        );
                      },
                    );
                  }

                  if (state is BrowseSuccess) {
                    if (state.movies.isEmpty) {
                      return const BrowserEmpty();
                    }

                    return MoviesGrid(movies: state.movies);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
