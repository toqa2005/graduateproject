import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../features/home/data/movie_model.dart';
import '../../../colors/Appcolors.dart';

class moviePoster extends StatelessWidget {
  final Movies movie;
  final double width;

  const moviePoster({
    required this.movie,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            movie.largeCoverImage ?? '',
            width: width,
            height: width * 1.45,
            fit: BoxFit.cover,
          ),
        ),

        // Play
        Container(
          decoration: const BoxDecoration(
            color: Appcolor.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow,
            color: Appcolor.red,
            size: 42,
          ),
        ),

        // Favorite
        Positioned(
          top: 5,
          right: 5,
          child: CircleAvatar(
            backgroundColor: Appcolor.black,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Appcolor.white,
                size: 19,
              ),
            ),
          ),
        ),
      ],
    );
  }
}