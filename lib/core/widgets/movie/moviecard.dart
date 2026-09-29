import 'package:flutter/material.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';
import '../../../features/movie_details/presentation/screens/movie_details.dart';
import '../../colors/Appcolors.dart';
import '../custom/rate.dart';

class MovieCard extends StatelessWidget {
  final Movies movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  void _openDetails(BuildContext context) {
    final id = movie.id;
    if (id == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(movieId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openDetails(context),
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(right: 12),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  movie.mediumCoverImage ?? movie.largeCoverImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade800,
                      child: const Icon(
                        Icons.movie,
                        color: Appcolor.white,
                      ),
                    );
                  },
                ),
              ),
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
                  color: Appcolor.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Rate(rating: movie.rating ?? 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
