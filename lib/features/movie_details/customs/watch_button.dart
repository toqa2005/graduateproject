import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/features/home/data/movie_model.dart';

class WatchButton extends StatelessWidget {
  final Movies movie;
  final VoidCallback? onPressed;

  const WatchButton({super.key, required this.movie, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 41,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.red,
          foregroundColor: Appcolor.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
        child: const Text(
          'Watch',
          style: TextStyle(
            color: Appcolor.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
