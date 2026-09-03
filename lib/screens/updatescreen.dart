import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/Appbar.dart';
import 'package:graduateproject/cusoms/CustomField.dart';
import 'package:graduateproject/cusoms/Customtextbutton.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/utils/Appimages.dart';
import 'package:graduateproject/utils/colors.dart';
import 'package:graduateproject/utils/routsapp.dart';

class Updatescreen extends StatelessWidget  {
  const Updatescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      appBar: CustomAppbar(text: 'Pick Avatar',)
      ,body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          children: [
            Center(
              child: Container(
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
                ),
                CustomField(
                  hintText: "01200000000 ",
                  icon: Icons.call,
                ),
                Align(
                  alignment: .centerLeft,
                  child: textbutton(text: "Reset Password", onPressed: () { Navigator.pushNamed(context, Routes.forgetpassword); },)),
                  Spacer(),
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
                  onPressed: () {},
                ),
          ],
        ),
      ),
    );
  }
}