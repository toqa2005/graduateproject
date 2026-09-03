import 'package:graduateproject/utils/Appimages.dart';
import 'package:graduateproject/utils/onboardingmodel.dart';
import 'package:graduateproject/utils/onboardingtexts.dart';

class OnBoardingData {
  static const List<OnBoardingModel> pages = [
    OnBoardingModel(
      image: OnBoardingImages.onboarding1,
      title: OnBoardingTexts.title1,
      body: OnBoardingTexts.body1,
    ),

    OnBoardingModel(
      image: OnBoardingImages.onboarding2,
      title: OnBoardingTexts.title2,
      body: OnBoardingTexts.body2,
    ),

    OnBoardingModel(
      image: OnBoardingImages.onboarding3,
      title: OnBoardingTexts.title3,
      body: OnBoardingTexts.body3,
    ),

    OnBoardingModel(
      image: OnBoardingImages.onboarding4,
      title: OnBoardingTexts.title4,
      body: OnBoardingTexts.body4,
    ),

    OnBoardingModel(
      image: OnBoardingImages.onboarding5,
      title: OnBoardingTexts.title5,
      body: OnBoardingTexts.body5,
    ),

    OnBoardingModel(
      image: OnBoardingImages.onboarding6,
      title: OnBoardingTexts.title6,
      body: OnBoardingTexts.body6,
    ),
  ];
}