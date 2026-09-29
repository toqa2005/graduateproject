import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/core/widgets/custom/CustomField.dart';
import 'package:graduateproject/core/widgets/custom/Customtextbutton.dart';
import 'package:graduateproject/core/widgets/custom/button.dart';
import 'package:graduateproject/core/images/Appimages.dart';
import 'package:graduateproject/core/routes/routsapp.dart';
import '../../../../core/colors/Appcolors.dart';
import '../../../../core/widgets/custom/snakBar.dart';
import '../cubit/auth_cubit.dart';
import '../../data/auth_repository.dart';
import '../../../../core/widgets/mainscreen.dart';
import '../cubit/authstate.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository()),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess || state is AuthGoogleLoginSuccess) {
            CustomSnakbar.show(context, text: 'Login successful');

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Appcolor.yellow,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: Text(state.message),
              ),
            );
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Appcolor.black,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 50,
                    ),
                    child: Column(
                      spacing: 15,
                      children: [
                        Image.asset(Appimages.logo, width: 120, height: 118),
                        CustomField(
                          hintText: "Email",
                          icon: Icons.email,
                          controller: emailController,
                        ),
                        CustomField(
                          hintText: "Password",
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: textbutton(
                            text: "forget password",
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.forgetpassword,
                              );
                            },
                          ),
                        ),
                        CustomButton(
                          text: "Login",
                          colorbutton: Appcolor.yellow,
                          colortext: Appcolor.black,
                          onPressed: () {
                            context.read<AuthCubit>().login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t Have Account ?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Appcolor.white,
                              ),
                            ),
                            textbutton(
                              text: "Create One",
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.registerscreen,
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Appcolor.yellow,
                                thickness: 1,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Appcolor.yellow,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Appcolor.yellow,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          text: "Login With Google",
                          colorbutton: Appcolor.yellow,
                          colortext: Appcolor.black,
                          onPressed: () {
                            context.read<AuthCubit>().loginWithGoogle();
                          },
                          icon: Icons.g_mobiledata,
                        ),
                      ],
                    ),
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
