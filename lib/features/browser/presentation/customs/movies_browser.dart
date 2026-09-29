import 'package:flutter/material.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';
import 'package:graduateproject/core/widgets/movie/moviecard.dart';

class MoviesGrid extends StatelessWidget {
  final List<Movies> movies;

  const MoviesGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    int columns;

    if (width >= 700) {
      columns = 4;
    } else if (width >= 450) {
      columns = 3;
    } else {
      columns = 2;
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      physics: const BouncingScrollPhysics(),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.64,
      ),
      itemBuilder: (context, index) {
        return MovieCard(movie: movies[index]);
      },
    );
  }
}
