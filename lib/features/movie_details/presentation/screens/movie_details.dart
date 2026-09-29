import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/features/movie_details/presentation/screens/movie_content.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';
import '../../data/movie_details_servise.dart';
import '../cubit/movie_det_cubit.dart';
import '../cubit/movie_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MovieDetailsCubit(MovieDetailsService())..getMovieDetails(movieId),
      child: const _MovieDetailsView(),
    );
  }
}

class _MovieDetailsView extends StatelessWidget {
  const _MovieDetailsView();

  Future<void> _watchOnYouTube(BuildContext context, Movies movie) async {
    final code = movie.ytTrailerCode?.trim();
    final title = movie.title?.trim();

    Uri uri;

    if (code != null && code.isNotEmpty) {
      uri = Uri.parse('https://www.youtube.com/watch?v=$code');
    } else if (title != null && title.isNotEmpty) {
      final query = Uri.encodeComponent('$title trailer');

      uri = Uri.parse('https://www.youtube.com/results?search_query=$query');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Movie title is not available')),
      );
      return;
    }

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open YouTube')));
    }
  }

  Future<void> _watchMovie(BuildContext context, Movies movie) async {
    await context.read<MovieDetailsCubit>().addCurrentMovieToHistory();

    if (!context.mounted) return;

    await _watchOnYouTube(context, movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolor.yellow),
            );
          }

          if (state is MovieDetailsFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Appcolor.white),
                ),
              ),
            );
          }

          if (state is MovieDetailsSuccess) {
            final movie = state.movieDetails.movie;

            return MovieContent(
              movie: movie,
              screenshots: state.movieDetails.screenshots,
              suggestions: state.suggestions,
              isInWatchList: state.isInWatchList,
              onFavorite: context.read<MovieDetailsCubit>().toggleWatchList,
              onWatch: () => _watchMovie(context, movie),
              onWatchButton: () => _watchMovie(context, movie),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

