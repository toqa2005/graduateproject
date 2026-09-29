import 'package:flutter/material.dart';
import 'package:graduateproject/core/widgets/movie/movie_details/movie_info.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';
import 'package:graduateproject/features/movie_details/customs/cast.dart';
import 'package:graduateproject/features/movie_details/customs/description.dart';
import 'package:graduateproject/features/movie_details/customs/genres.dart';
import 'package:graduateproject/features/movie_details/customs/movie_hero_section.dart';
import 'package:graduateproject/features/movie_details/customs/screenshots.dart';
import 'package:graduateproject/features/movie_details/customs/section_title.dart';
import 'package:graduateproject/features/movie_details/customs/sugesstion.dart';
import 'package:graduateproject/features/movie_details/customs/watch_button.dart';

class MovieContent extends StatelessWidget {
  final Movies movie;
  final List<String> screenshots;
  final List<Movies> suggestions;
  final bool isInWatchList;
  final VoidCallback onFavorite;
  final VoidCallback onWatch;
  final Future<void> Function() onWatchButton;

  const MovieContent({
    required this.movie,
    required this.screenshots,
    required this.suggestions,
    required this.isInWatchList,
    required this.onFavorite,
    required this.onWatch,
    required this.onWatchButton,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: MovieHero(
            movie: movie,
            isInWatchList: isInWatchList,
            onFavorite: onFavorite,
            onPlay: onWatch,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(11, 0, 11, 30),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              WatchButton(movie: movie, onPressed: onWatchButton),
              const SizedBox(height: 10),
              movieInfo(movie: movie),
              if (screenshots.isNotEmpty) ...[
                const SizedBox(height: 18),
                const SectionTitle('Screen Shots'),
                const SizedBox(height: 9),
                Screenshots(images: screenshots),
              ],
              if (suggestions.isNotEmpty) ...[
                const SizedBox(height: 18),
                const SectionTitle('Similar'),
                const SizedBox(height: 9),
                Suggestions(movies: suggestions),
              ],
              const SizedBox(height: 18),
              const SectionTitle('Summary'),
              const SizedBox(height: 8),
              Description(
                text:
                    movie.descriptionFull ??
                    movie.summary ??
                    movie.synopsis ??
                    'No description available.',
              ),
              if (movie.cast?.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                const SectionTitle('Cast'),
                const SizedBox(height: 8),
                CastList(cast: movie.cast!),
              ],
              if (movie.genres?.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                const SectionTitle('Genres'),
                const SizedBox(height: 8),
                Genres(genres: movie.genres!),
              ],
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ],
    );
  }
}
