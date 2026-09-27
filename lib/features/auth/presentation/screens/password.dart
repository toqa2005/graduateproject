import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/core/widgets/Appbar.dart';
import 'package:graduateproject/core/widgets/button.dart';
import 'package:graduateproject/core/widgets/CustomField.dart';
import 'package:graduateproject/core/images/Appimages.dart';
import 'package:graduateproject/features/auth/data/auth_repository.dart';
import 'package:graduateproject/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduateproject/features/auth/presentation/cubit/authstate.dart';

import '../../../../core/colors/Appcolors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
                content: Text(
                  'Password reset email sent successfully',
                ),
              ),
            );
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Appcolor.black,
              appBar: CustomAppbar(
                text: 'Forget pasword',
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        Appimages.forgetpassword,
                        width: 430,
                        height: 430,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 25),
                      CustomField(
                        hintText: 'Email',
                        icon: Icons.email,
                        controller: emailController,
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        text: 'Verify Email',
                        colorbutton: Appcolor.yellow,
                        colortext: Appcolor.black,
                        onPressed: () {
                          context.read<AuthCubit>().resetPassword(
                            email: emailController.text,
                          );
                        },
                      ),
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