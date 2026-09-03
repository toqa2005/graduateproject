import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/utils/colors.dart';
import 'package:graduateproject/utils/onboardingdata.dart';

import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.black,
      showNextButton: false,
      showDoneButton: false,
      showBackButton: false,
      isProgress: false,
      pages: List.generate(
        OnBoardingData.pages.length,
        (index) {
          final screen = OnBoardingData.pages[index];

          return PageViewModel(
            image: Image.asset(
              screen.image,
              fit: BoxFit.cover,
            ),
            title: screen.title,
            body: screen.body,
            footer: Column(
              children: [
                CustomButton(
                  text: index == OnBoardingData.pages.length - 1
                      ? 'Finish'
                      : 'Next',
                  colorbutton: Appcolor.yellow,
                  colortext: Colors.black,
                  onPressed: () {},
                ),
                if (index > 0) ...[
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Back',
                    colorbutton: Colors.transparent,
                    colortext: Appcolor.yellow,
                    onPressed: () {},
                  ),
                ],
              ],
            ),
            decoration: const PageDecoration(
              pageColor: Colors.black,
              imagePadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              bodyPadding: EdgeInsets.zero,
              footerPadding: EdgeInsets.zero,
            ),
          );
        },
      ),
    );
  }
}