import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/rate.dart';
import 'package:graduateproject/models/movie_model.dart';

import '../../utils/colors.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({
    super.key,
    required this.movie,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      margin: const EdgeInsets.only(
        right: 12,
      ),
      child: Expanded(
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(15),
                child: Image.network(
                  movie.mediumCoverImage,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (
                      context,
                      error,
                      stackTrace,
                      ) {
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
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color:
                 Appcolor.black,
                  borderRadius:
                  BorderRadius.circular(6),
                ),
                child:Rate(rating: movie.rating)
              ),
            ),
          ],
        ),
      ),
    );
  }
}