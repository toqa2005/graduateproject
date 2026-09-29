import 'package:flutter/material.dart';
import '../../../../features/home/data/movie_model.dart';
import '../../../colors/Appcolors.dart';

class movieInfo extends StatelessWidget {
  final Movies movie;

  const movieInfo({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Info(
            icon: Icons.favorite,
            text: '${movie.likeCount ?? 0}',
          ),
        ),
        Expanded(
          child: _Info(
            icon: Icons.access_time,
            text: '${movie.runtime ?? 0}',
          ),
        ),
        Expanded(
          child: _Info(
            icon: Icons.star,
            text: '${movie.rating ?? 0}',
          ),
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Info({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: Appcolor.gray,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Appcolor.yellow,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Appcolor.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
