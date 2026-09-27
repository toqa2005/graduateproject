import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduateproject/core/widgets/Appbar.dart';
import 'package:graduateproject/core/widgets/CustomField.dart';
import 'package:graduateproject/core/widgets/Customtextbutton.dart';
import 'package:graduateproject/core/widgets/button.dart';
import 'package:graduateproject/core/images/Appimages.dart';
import 'package:graduateproject/core/routes/routsapp.dart';
import 'package:graduateproject/features/auth/data/auth_repository.dart';
import 'package:graduateproject/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduateproject/features/auth/presentation/cubit/authstate.dart';

import '../../../../core/colors/Appcolors.dart';

class Updatescreen extends StatefulWidget {
  const Updatescreen({super.key});

  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository()),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Data updated successfully",
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
                text: 'Pick Avatar',
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                            Appimages.Avatar1,
                          ),
                        ),
                      ),
                    ),
                    CustomField(
                      hintText: "John Safwat",
                      icon: Icons.person,
                      controller: nameController,
                    ),
                    CustomField(
                      hintText: "01200000000",
                      icon: Icons.call,
                      controller: phoneController,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textbutton(
                        text: "Reset Password",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.forgetpassword,
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Delete Account",
                      colorbutton: Appcolor.red,
                      colortext: Appcolor.white,
                      onPressed: () {},
                    ),
                    CustomButton(
                      text: "Update Data",
                      colorbutton: Appcolor.yellow,
                      colortext: Appcolor.black,
                      onPressed: () {
                        context.read<AuthCubit>().updateProfile(
                          name: nameController.text,
                          phone: phoneController.text,
                        );
                      },
                    ),
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