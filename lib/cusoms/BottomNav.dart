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
        children: [
          _item(
            icon: Icons.home_outlined,
            index: 0,
          ),
          _item(
            icon: Icons.search,
            index: 1,
          ),
          _item(
            icon: Icons.movie_outlined,
            index: 2,
          ),
          _item(
            icon: Icons.person_outline,
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required int index,
  }) {
    final bool selected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          onTap(index);
        },
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              size: 26,
              color: selected
                  ? Appcolor.yellow
                  : Appcolor.white,
            ),
          ),
        ),
      ),
    );
  }
}