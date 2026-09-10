import 'package:flutter/material.dart';
import 'package:graduateproject/cusoms/Appbar.dart';
import 'package:graduateproject/cusoms/CustomField.dart';
import 'package:graduateproject/cusoms/Customtextbutton.dart';
import 'package:graduateproject/cusoms/button.dart';
import 'package:graduateproject/utils/Appimages.dart';
import 'package:graduateproject/utils/colors.dart';
import 'package:graduateproject/utils/routsapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Updatescreen extends StatefulWidget {
  const Updatescreen({super.key});

  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

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
                  controller: nameController,
                ),
                CustomField(
                  hintText: "01200000000 ",
                  icon: Icons.call,
                  controller: phoneController,
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
              onPressed: () async {
                try {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    await user.updateDisplayName(
                      nameController.text.trim(),
                    );

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .update({
                      'name': nameController.text.trim(),
                      'phone': phoneController.text.trim(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Data updated successfully"),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: $e"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}