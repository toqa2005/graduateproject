import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';

class EmptySearch extends StatelessWidget {
  final String query;

  const EmptySearch({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, color: Appcolor.yellow, size: 55),

          const SizedBox(height: 12),
          const Text(
            'No Movies Found',
            style: TextStyle(
              color: Appcolor.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'No results for "$query"',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Appcolor.gray, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
