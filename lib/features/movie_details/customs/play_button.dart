import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PlayButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: Appcolor.yellow,
            shape: BoxShape.circle,
            border: Border.all(color: Appcolor.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.35),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.play_arrow, color: Appcolor.white, size: 38),
        ),
      ),
    );
  }
}
