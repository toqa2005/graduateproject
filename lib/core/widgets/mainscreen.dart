import 'package:flutter/material.dart';
import 'package:graduateproject/core/widgets/BottomNav.dart';
import 'package:graduateproject/features/home/presentation/screens/homescreen.dart';
import '../../features/browser/presentation/screens/browser_tab.dart';
import '../../features/profile_screen/presentation/screens/profile_screen.dart';

import '../../features/search/presentation/screen/searchscreen.dart';
import '../colors/Appcolors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final profileKey = GlobalKey<ProfilescreenState>();

  late final List<Widget> pages = [
    const HomeScreen(),
    const Searchscreen(),
    const Browser(),
    Profilescreen(key: profileKey),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 3) {
            profileKey.currentState?.refresh();
          }
        },
      ),
    );
  }
}