import 'package:flutter/material.dart';

import 'package:graduateproject/core/colors/Appcolors.dart';

class Genres extends StatelessWidget {
  final List<String> genres;

  const Genres({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: genres.map((genre) {
        return Container(
          width: 86,
          padding: const EdgeInsets.symmetric(vertical: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Appcolor.gray,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            genre,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Appcolor.white, fontSize: 10),
          ),
        );
      }).toList(),
    );
  }
}
