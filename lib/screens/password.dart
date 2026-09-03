import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/Appbar.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/cusoms/CustomField.dart';
import 'package:graduateproject/utils/Appimages.dart';
import 'package:graduateproject/utils/colors.dart';
import 'package:graduateproject/utils/routsapp.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,

      appBar: CustomAppbar(text: 'Forget pasword',),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              // Illustration
              Image.asset(
              Appimages.forgetpassword,
                width: 430,
                height: 430
                ,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 25),

              CustomField(
                hintText: 'Email',
                icon: Icons.email,
              ),

              const SizedBox(height: 12),

              CustomButton(
                text: 'Verify Email',
                colorbutton: Appcolor.yellow,
                colortext: Appcolor.black,
                onPressed: () {Navigator.pushNamed(context, Routes.updatescreen);},
              ),
            ],
          ),
        ),
      ),
    );
  }
}