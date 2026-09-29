import 'package:flutter/material.dart';

import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';

class CastList extends StatelessWidget {
  final List<Cast> cast;

  const CastList({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cast.take(8).map((person) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Appcolor.gray,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  person.urlSmallImage ?? '',
                  width: 49,
                  height: 49,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 49,
                      height: 49,
                      color: Colors.black26,
                      child: const Icon(Icons.person, color: Colors.white54),
                    );
                  },
                ),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name : ${person.name ?? '-'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Appcolor.white,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      'Character : ${person.characterName ?? '-'}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Appcolor.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
