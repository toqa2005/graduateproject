import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color colortext;
  final Color colorbutton;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.colorbutton,
    required this.colortext,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorbutton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Appcolor.yellow,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colortext,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}