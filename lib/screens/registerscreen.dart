
import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/Appbar.dart';
import 'package:graduateproject/cusoms/Customtextbutton.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/cusoms/CustomField.dart';
import 'package:graduateproject/cusoms/language.dart';
import 'package:graduateproject/utils/avatar.dart';
import 'package:graduateproject/utils/colors.dart';
import 'package:graduateproject/screens/loginscreen.dart';
import 'package:graduateproject/utils/routsapp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const loginscreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,

      appBar: CustomAppbar(text: 'Register',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),

          child: Column(
            children: [

              const SizedBox(height: 4),


              // Avatar
              const Avatar(),
const SizedBox(height: 12),
              const Text(
                'Avatar',
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: 16,
                ),
              ),

              
              const SizedBox(height: 18),

              // Name
              CustomField(
                hintText: 'Name',
                icon: Icons.badge_outlined,
              ),

              const SizedBox(height: 12),

              // Email
              CustomField(
                hintText: 'Email',
                icon: Icons.email,
              ),

              const SizedBox(height: 12),

              // Password
              CustomField(
                hintText: 'Password',
                icon: Icons.lock,
                icon2: Icons.visibility_off,
              ),

              const SizedBox(height: 12),

              // Confirm Password
              CustomField(
                hintText: 'Confirm Password',
                icon: Icons.lock,
                icon2: Icons.visibility_off,
              ),

              const SizedBox(height: 12),

              // Phone Number
              CustomField(
                hintText: 'Phone Number',
                icon: Icons.phone,
              ),

              const SizedBox(height: 16),

              // Create Account
              CustomButton(
                text: 'Create Account',
                colorbutton: Appcolor.yellow,
                colortext: Appcolor.black,
                onPressed: goToLogin,
              ),

              const SizedBox(height: 8),

              // Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already Have Account ? ',
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: 14
                      ,
                    ),
                  ),

                  textbutton(
                    text: "Login",
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.loginscreen,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Language
              Language(),
            ],
          ),
        ),
      ),
    );
  }
}