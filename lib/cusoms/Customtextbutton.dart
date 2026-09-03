import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class textbutton extends StatelessWidget {
   String text;
   textbutton({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
  onPressed: () {
    // الكود اللي هيشتغل لما تضغطي
  },
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