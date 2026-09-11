
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduateproject/cusoms/CustomField.dart';
import 'package:graduateproject/cusoms/Customtextbutton.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/cusoms/language.dart';
import 'package:graduateproject/utils/Appimages.dart';
import 'package:graduateproject/utils/colors.dart';
import 'package:graduateproject/utils/routsapp.dart';
import 'package:graduateproject/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/google_auth.dart';


class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter email and password"),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful"),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;

      if (e.code == 'user-not-found') {
        message = "No account found with this email";
      } else if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        message = "Email or password is incorrect";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email";
      } else {
        message = e.message ?? "Login failed";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 50),
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
                  hintText: "password",
                  icon: Icons.lock,
                  icon2: Icons.visibility_off,
                  controller: passwordController,
                ),
                Align(
                    alignment: .centerRight,
                    child: textbutton(text: "forget password", onPressed: () { Navigator.pushNamed(context, Routes.forgetpassword); },)),
                CustomButton(
                  text: "Login",
                  colorbutton: Appcolor.yellow,
                  colortext: Appcolor.black,
                  onPressed: login,
                ),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "Don’t Have Account ?",
                      style: TextStyle(fontSize: 14, color: Appcolor.white),
                    ),
                    textbutton(text: "Create One", onPressed: () {Navigator.pushNamed(context, Routes.registerscreen);  },),
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
                  onPressed: () async {
                    await GoogleAuth.login(context);
                    if (!context.mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  icon: Icons.g_mobiledata,
                ),
                Language()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
