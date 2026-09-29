import 'package:flutter/material.dart';

import 'package:graduateproject/features/home/data/movie_model.dart';

import 'package:graduateproject/core/widgets/movie/smallCard.dart';

class Suggestions extends StatelessWidget {
  final List<Movies> movies;

  const Suggestions({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return SmallCard(movie: movies[index]);
        },
      ),
    );
  }
}
