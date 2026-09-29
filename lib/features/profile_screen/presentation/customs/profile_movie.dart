import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/core/widgets/custom/rate.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';

import '../../../movie_details/presentation/screens/movie_details.dart';
import '../cubit/profile_cubit.dart';

class ProfileMovie extends StatelessWidget {
  final List<Movies> movies;

  const ProfileMovie({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final columns = constraints.maxWidth >= 700
            ? 5
            : constraints.maxWidth >= 500
            ? 4
            : constraints.maxWidth >= 330
            ? 3
            : 2;

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: movies.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 8,
            mainAxisSpacing: 9,
            childAspectRatio: .64,
          ),
          itemBuilder: (_, index) {
            return _ProfileMovieCard(
              movie: movies[index],
            );
          },
        );
      },
    );
  }
}

class _ProfileMovieCard extends StatelessWidget {
  final Movies movie;

  const _ProfileMovieCard({
    required this.movie,
  });

  Future<void> _openDetails(BuildContext context) async {
    final id = movie.id;

    if (id == null) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(
          movieId: id,
        ),
      ),
    );

    if (context.mounted) {
      context.read<ProfileCubit>().loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = movie.mediumCoverImage ??
        movie.largeCoverImage ??
        movie.smallCoverImage ??
        '';

    return GestureDetector(
      onTap: () => _openDetails(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: Appcolor.gray,
                  child: const Icon(
                    Icons.movie,
                    color: Colors.white54,
                  ),
                );
              },
            ),

            Positioned(
              top: 5,
              left: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Rate(
                  rating: movie.rating ?? 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}