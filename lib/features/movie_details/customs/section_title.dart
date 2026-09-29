import 'package:flutter/material.dart';

import 'package:graduateproject/core/colors/Appcolors.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Appcolor.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
