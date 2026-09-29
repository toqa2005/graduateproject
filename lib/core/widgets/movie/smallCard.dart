import 'package:flutter/material.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';
import '../../../features/movie_details/presentation/screens/movie_details.dart';
import '../../colors/Appcolors.dart';
import '../custom/rate.dart';

class SmallCard extends StatelessWidget {
  final Movies movie;
  final VoidCallback? onTap;

  const SmallCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  void _openDetails(BuildContext context) {
    if (onTap != null) {
      onTap!();
      return;
    }

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
        width: 146,
        height: 220,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        movie.mediumCoverImage ?? movie.largeCoverImage ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade800,
                            child: const Icon(
                              Icons.movie,
                              color: Colors.white,
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
                        vertical: 5,
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
          ],
        ),
      ),
    );
  }
}
