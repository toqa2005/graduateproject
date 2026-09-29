
import 'package:flutter/material.dart';

import '../../colors/Appcolors.dart';

class CustomSnakbar {
static void show(
BuildContext context, {
required String text,
Color backgroundColor = Appcolor.yellow,
Color textColor = Appcolor.black,
}) {
ScaffoldMessenger.of(context).hideCurrentSnackBar();

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
text,
style: TextStyle(
color: textColor,
fontSize: 15,
fontWeight: FontWeight.bold,
),
),
backgroundColor: backgroundColor,
behavior: SnackBarBehavior.floating,
margin: const EdgeInsets.all(16),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
duration: const Duration(seconds: 3),
),
);
}
}
