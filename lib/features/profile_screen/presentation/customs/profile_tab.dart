import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';

class ProfileTabs extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onChanged;

  const ProfileTabs({
    super.key,
    required this.selectedTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      height: 63,
      color: const Color(0xFF242424),
      child: Row(
        children: [
          Tab(
            selected: selectedTab == 0,
            icon: Icons.format_list_bulleted,
            title: 'Watch List',
            onTap: () => onChanged(0),
          ),

          Tab(
            selected: selectedTab == 1,
            icon: Icons.folder,
            title: 'History',
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class Tab extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const Tab({
    required this.selected,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected
                  ? Appcolor.yellow
                  : Appcolor.white,
              size: 22,
            ),

            const SizedBox(height: 3),

            Text(
              title,
              style: const TextStyle(
                color: Appcolor.white,
                fontSize: 12,
              ),
            ),

            const Spacer(),

            Container(
              height: 2,
              color: selected
                  ? Appcolor.yellow
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}