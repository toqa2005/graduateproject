import 'package:flutter/material.dart';
import 'package:graduateproject/models/movie_model.dart';

import '../../utils/colors.dart';
import '../rate.dart';

class SmallCard extends StatelessWidget {
  final Movies movie;

  const SmallCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146,
      height: 220,
      margin: const EdgeInsets.only(
        right: 12,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      movie.mediumCoverImage ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (
                          context,
                          error,
                          stackTrace,
                          ) {
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
                    child: Rate(
                      rating: movie.rating ?? 0.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}