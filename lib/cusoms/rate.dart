import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class Rate extends StatelessWidget {
  final double rating;

  const Rate({
    super.key,
    required this.rating,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toString(),
          style: const TextStyle(
            color: Appcolor.white,
            fontSize: 9,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(
          Icons.star,
          color: Appcolor.yellow,
          size: 11,
        ),
      ],
    );
  }
}