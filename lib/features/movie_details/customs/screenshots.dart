import 'package:flutter/material.dart';

import 'package:graduateproject/core/colors/Appcolors.dart';

class Screenshots extends StatelessWidget {
  final List<String> images;

  const Screenshots({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < images.length; i++) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 2.35,
              child: Image.network(
                images[i],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: Appcolor.gray,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white54,
                    ),
                  );
                },
              ),
            ),
          ),

          if (i != images.length - 1) const SizedBox(height: 9),
        ],
      ],
    );
  }
}
