import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/BottomNav.dart';
import 'package:graduateproject/screens/homescreen.dart';
import 'package:graduateproject/screens/moviescreen.dart';
import 'package:graduateproject/screens/profilescreen.dart';
import 'package:graduateproject/screens/searchscreen.dart';

import '../utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const Searchscreen(),
    const Moviescreen(),
    const Profilescreen(),
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
        },
      ),
    );
  }
}