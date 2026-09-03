import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduateproject/cusoms/CustomField.dart';
import 'package:graduateproject/cusoms/Customtextbutton.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/utils/Appimages.dart';
import 'package:graduateproject/utils/colors.dart';

class loginscreen extends StatelessWidget {
  const loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 15,
              children: [
                Image.asset(Appimages.logo, width: 120, height: 118),
                CustomField(hintText: "Email", icon: Icons.email),
                CustomField(
                  hintText: "password",
                  icon: Icons.lock,
                  icon2: Icons.visibility_off,
                ),
                Align(
                  alignment: .centerRight,
                  child: textbutton(text: "forget password")),
                CustomButton(
                  text: "logo",
                  colorbutton: Appcolor.yellow,
                  colortext: Appcolor.black,
                  onPressed: () {},
                ),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "Don’t Have Account ?",
                      style: TextStyle(fontSize: 14, color: Appcolor.white),
                    ),
                    textbutton(text: "Create One"),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.amber, thickness: 1)),
          
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.amber, fontSize: 12),
                      ),
                    ),
          
                    Expanded(child: Divider(color: Colors.amber, thickness: 1)),
                  ],
                ),
                CustomButton(
                  text: "Login With Google",
                  colorbutton: Appcolor.yellow,
                  colortext: Appcolor.black,
                  onPressed: () {},
                  icon: Icons.g_mobiledata,
                ),
                Container(
                  width: 92,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          Appimages.Eg,
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
          
                      ClipOval(
                        child: Image.asset(
                          Appimages.LR,
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
