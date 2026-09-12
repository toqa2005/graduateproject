import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/Appbar.dart';
import 'package:graduateproject/cusoms/CustomField.dart';
import 'package:graduateproject/cusoms/Customtextbutton.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/services/auth_services.dart';
import 'package:graduateproject/utils/avatar.dart';
import 'package:graduateproject/utils/colors.dart';
import 'package:graduateproject/utils/routsapp.dart';

import 'mainscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  Future<void> register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    final user = await AuthService().register(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
    );

    if (!mounted) return;

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed'),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      appBar: CustomAppbar(
        text: 'Register',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          child: Column(
            children: [
              const SizedBox(height: 4),
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
              CustomField(
                hintText: 'Name',
                icon: Icons.badge_outlined,
                controller: nameController,
              ),
              const SizedBox(height: 12),
              CustomField(
                hintText: 'Email',
                icon: Icons.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CustomField(
                hintText: 'Password',
                icon: Icons.lock,
                icon2: isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                controller: passwordController,
                obscureText: !isPasswordVisible,
                onIcon2Pressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 12),
              CustomField(
                hintText: 'Confirm Password',
                icon: Icons.lock,
                icon2: isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                controller: confirmPasswordController,
                obscureText: !isConfirmPasswordVisible,
                onIcon2Pressed: () {
                  setState(() {
                    isConfirmPasswordVisible =
                    !isConfirmPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 12),
              CustomField(
                hintText: 'Phone Number',
                icon: Icons.phone,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Create Account',
                colorbutton: Appcolor.yellow,
                colortext: Appcolor.black,
                onPressed: register,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already Have Account ? ',
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: 14,
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
            ],
          ),
        ),
      ),
    );
  }
}