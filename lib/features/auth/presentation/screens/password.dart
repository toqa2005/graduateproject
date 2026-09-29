import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduateproject/core/colors/Appcolors.dart';
import 'package:graduateproject/core/images/Appimages.dart';
import 'package:graduateproject/core/widgets/Appbar.dart';
import 'package:graduateproject/core/widgets/custom/CustomField.dart';
import 'package:graduateproject/core/widgets/custom/button.dart';

import 'package:graduateproject/features/auth/data/auth_repository.dart';
import 'package:graduateproject/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduateproject/features/auth/presentation/cubit/authstate.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _resetPassword(BuildContext context) {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Appcolor.yellow,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          content: Text(
            'Please enter your email',
            style: TextStyle(color: Appcolor.black),
          ),
        ),
      );
      return;
    }

    context.read<AuthCubit>().resetPassword(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository()),

      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {

          if (state is AuthResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Appcolor.yellow,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16),
                content: Text(
                  'Password reset email sent successfully',
                  style: TextStyle(color: Appcolor.black),
                ),
              ),
            );

            Navigator.of(context).pop();
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Appcolor.yellow,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                content: Text(
                  state.message,
                  style: const TextStyle(color: Appcolor.black),
                ),
              ),
            );
          }
        },

        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Appcolor.black,

              appBar: const CustomAppbar(text: 'Forget Password'),

              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                child: Column(
                  children: [
                    // =========================
                    // Image
                    // =========================
                    Image.asset(
                      Appimages.forgetpassword,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 15),

                    CustomField(
                      hintText: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 15),

                    CustomButton(
                      text: 'Verify Email',
                      colorbutton: Appcolor.yellow,
                      colortext: Appcolor.black,
                      onPressed: () {
                        _resetPassword(context);
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
