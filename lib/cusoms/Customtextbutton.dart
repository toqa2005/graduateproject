import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class textbutton extends StatelessWidget {
   String text;
    final VoidCallback onPressed;

   textbutton({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
  onPressed: onPressed,
  child: Text(
   text,
    style: TextStyle(
      color:Appcolor.yellow,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  ),
);
  }
}