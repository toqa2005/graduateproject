import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';

class MovieHero extends StatelessWidget {
  final Movies movie;
  final bool isInWatchList;
  final VoidCallback onFavorite;
  final VoidCallback onPlay;

  const MovieHero({
    super.key,
    required this.movie,
    required this.isInWatchList,
    required this.onFavorite,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final title =
        movie.titleLong ?? movie.title ?? movie.titleEnglish ?? 'Unknown Movie';

    final image =
        movie.backgroundImageOriginal ??
        movie.backgroundImage ??
        movie.largeCoverImage ??
        movie.mediumCoverImage ??
        '';

    return SizedBox(
      height: 455,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Appcolor.black),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.25),
                  Colors.black.withOpacity(.18),
                  Appcolor.black.withOpacity(.35),
                  Appcolor.black,
                ],
                stops: const [0, .35, .72, 1],
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Appcolor.white,
                size: 24,
              ),
            ),
          ),
          Positioned(
            top: 18,
            right: 10,
            child: IconButton(
              onPressed: onFavorite,
              icon: Icon(
                isInWatchList ? Icons.bookmark : Icons.bookmark_border,
                color: Appcolor.white,
                size: 27,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: onPlay,
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: Appcolor.yellow,
                  shape: BoxShape.circle,
                  border: Border.all(color: Appcolor.white, width: 5),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Appcolor.white,
                  size: 38,
                ),
              ),
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            bottom: 16,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Appcolor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${movie.year ?? '-'}',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
