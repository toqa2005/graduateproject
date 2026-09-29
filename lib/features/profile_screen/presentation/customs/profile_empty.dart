import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';

class ProfileEmpty extends StatelessWidget {
  final bool history;

  const ProfileEmpty({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/Empty.png',
            width: 130,
            height: 130,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 15),
          Text(
            history ? 'Your History is Empty' : 'Your Watch List is Empty',
            style: const TextStyle(color: Appcolor.gray, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
