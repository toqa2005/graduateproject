import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduateproject/features/home/presentation/screens/homescreen.dart';
import 'package:graduateproject/features/auth/presentation/screens/loginscreen.dart';
import 'package:graduateproject/features/auth/presentation/screens/password.dart';
import 'package:graduateproject/features/auth/presentation/screens/registerscreen.dart';
import 'package:graduateproject/features/auth/presentation/screens/updatescreen.dart';
import 'package:graduateproject/core/routes/routsapp.dart';
import 'core/widgets/mainscreen.dart';
import 'features/onboarding/presentation/onboardingscreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GoogleSignIn.instance.initialize(
    serverClientId:
        "882399206308-1tbm7ncm0q3t7dt378oo09unsa6hcti1.apps.googleusercontent.com",
  );

  final prefs = await SharedPreferences.getInstance();

  final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

  final user = FirebaseAuth.instance.currentUser;
  Widget startScreen;
  if (user != null) {
    startScreen = const MainScreen();
  } else if (!onboardingCompleted) {
    startScreen = OnBoardingScreen();
  } else {
    startScreen = loginscreen();
  }
  runApp(MyApp(startScreen: startScreen));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;

  const MyApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startScreen,
      routes: {
        Routes.onboarding: (context) => OnBoardingScreen(),
        Routes.homescreen: (context) => const HomeScreen(),
        Routes.loginscreen: (context) => loginscreen(),
        Routes.registerscreen: (context) => RegisterScreen(),
        Routes.forgetpassword: (context) => ForgetPassword(),
        Routes.updatescreen: (context) => Updatescreen(),
      },
    );
  }
}
