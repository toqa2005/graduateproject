import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/core/widgets/Appbar.dart';
import 'package:graduateproject/core/widgets/custom/CustomField.dart';
import 'package:graduateproject/core/widgets/custom/Customtextbutton.dart';
import 'package:graduateproject/core/widgets/custom/button.dart';
import 'package:graduateproject/core/widgets/auth/avatar.dart';
import 'package:graduateproject/core/routes/routsapp.dart';
import 'package:graduateproject/features/auth/data/auth_repository.dart';
import 'package:graduateproject/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduateproject/features/auth/presentation/cubit/authstate.dart';

import '../../../../core/colors/Appcolors.dart';
import '../../../../core/images/Appimages.dart';
import '../../../../core/widgets/mainscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedAvatar = Appimages.Avatar1;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository()),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account created successfully')),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Appcolor.black,
              appBar: CustomAppbar(text: 'Register'),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Avatar(
                        initialAvatar: selectedAvatar,
                        onChanged: (avatar) {
                          setState(() {
                            selectedAvatar = avatar;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Avatar',
                        style: TextStyle(color: Appcolor.white, fontSize: 16),
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
                        onPressed: () {
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

                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Passwords do not match'),
                              ),
                            );
                            return;
                          }

                          context.read<AuthCubit>().register(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            avatarAsset: selectedAvatar,
                          );
                        },
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
                              Navigator.pushNamed(context, Routes.loginscreen);
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
          },
        ),
      ),
    );
  }
}
