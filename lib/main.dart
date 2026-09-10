import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduateproject/screens/loginscreen.dart';
import 'package:graduateproject/screens/onboardingscreen.dart';
import 'package:graduateproject/screens/password.dart';
import 'package:graduateproject/screens/registerscreen.dart';
import 'package:graduateproject/screens/updatescreen.dart';
import 'package:graduateproject/utils/routsapp.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.onboarding,
     routes: {Routes.onboarding:(context)=>OnBoardingScreen(),
     Routes.loginscreen:(context)=>loginscreen(),
     Routes.registerscreen:(context)=>RegisterScreen(),
     Routes.forgetpassword:(context)=>ForgetPassword(),
     Routes.updatescreen:(context)=>Updatescreen(),
     },
    );}}
