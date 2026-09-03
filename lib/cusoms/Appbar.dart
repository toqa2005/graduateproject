import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
   final String text;
  const CustomAppbar({super.key ,required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Appcolor.black,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Appcolor.yellow,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title:  Text(
          text,
          style: TextStyle(
            color: Appcolor.yellow,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }

 @override
Size get preferredSize => const Size.fromHeight(kToolbarHeight);}