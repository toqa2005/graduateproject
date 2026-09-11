import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,

      margin: const EdgeInsets.all(8),

      decoration: BoxDecoration(
        color: Appcolor.gray,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(
            icon: Icons.home_outlined,
            label: "Home",
            index: 0,
          ),

          _item(
            icon: Icons.search,
            label: "Search",
            index: 1,
          ),

          _item(
            icon: Icons.movie_outlined,
            label: "Movies",
            index: 2,
          ),
          _item(
            icon: Icons.person_pin,
            label: "Profile",
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool selected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),

        borderRadius: BorderRadius.circular(10),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: selected
                    ? Appcolor.yellow
                    : Appcolor.white,
              ),
              const SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}