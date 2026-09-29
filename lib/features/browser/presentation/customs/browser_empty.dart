import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';

class BrowserEmpty extends StatelessWidget {
  const BrowserEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.movie_filter_outlined,
            color: Appcolor.yellow,
            size: 55,
          ),
          const SizedBox(height: 12),
          const Text(
            'No Movies Found',
            style: TextStyle(
              color: Appcolor.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Try another genre',
            style: TextStyle(
              color: Colors.white.withOpacity(.45),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
