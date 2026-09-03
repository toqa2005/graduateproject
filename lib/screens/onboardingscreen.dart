import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/screens/loginscreen.dart';
import 'package:graduateproject/utils/colors.dart';
import 'package:graduateproject/utils/onboardingdata.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < OnBoardingData.pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const loginscreen(),
        ),
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: pageController,
        itemCount: OnBoardingData.pages.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final screen = OnBoardingData.pages[index];

          final bool isLastPage =
              index == OnBoardingData.pages.length - 1;

          return Stack(
            children: [
            
              Positioned.fill(
                child: Image.asset(
                  screen.image,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),

  
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    25,
                    18,
                    20,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      Text(
                        screen.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 14),
                      Text(
                        screen.body,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 63, 62, 62),
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (index == 0) ...[
                        CustomButton(
                          text: "Explore Now",
                          colorbutton: Appcolor.yellow,
                          colortext: Colors.black,
                          onPressed: nextPage,
                        ),
                      ]

                      // Second Page - Next only
                      else if (index == 1) ...[
                        CustomButton(
                          text: "Next",
                          colorbutton: Appcolor.yellow,
                          colortext: Colors.black,
                          onPressed: nextPage,
                        ),
                      ]
                      else ...[
                        CustomButton(
                          text: isLastPage ? "Finish" : "Next",
                          colorbutton: Appcolor.yellow,
                          colortext: Colors.black,
                          onPressed: nextPage,
                        ),

                        const SizedBox(height: 10),

                        CustomButton(
                          text: "Back",
                          hasBorder: true,
                          colorbutton: Appcolor.black,
                          colortext: Appcolor.yellow,
                          onPressed: previousPage,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}