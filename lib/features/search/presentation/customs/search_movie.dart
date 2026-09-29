import 'package:flutter/material.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';
import '../../../../core/widgets/movie/smallCard.dart';

class MovieSearch extends StatelessWidget {
  final List<Movies> movies;

  const MovieSearch({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 1000
            ? 5
            : width >= 750
            ? 4
            : width >= 500
            ? 3
            : 2;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(9, 8, 9, 20),
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 146 / 220,
          ),
          itemBuilder: (context, index) {
            return SmallCard(movie: movies[index]);
          },
        );
      },
    );
  }
}
