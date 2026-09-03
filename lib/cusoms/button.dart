import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color colortext;
  final Color colorbutton;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool hasBorder;

  const CustomButton({
    super.key,
    required this.text,
    required this.colorbutton,
    required this.colortext,
    required this.onPressed,
    this.icon,
    this.hasBorder = false,
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
            borderRadius: BorderRadius.circular(15),
            side: hasBorder
                ? BorderSide(
                    color: Appcolor.yellow,
                    width: 2,
                  )
                : BorderSide.none,
          
          ),
        ),
        child: 
         
          Row(
            mainAxisAlignment: .center,
            children: [
              Icon(icon,color: Appcolor.black,size: 30,),
              Text(
                text,
                style: TextStyle(
                  color: colortext,
                  fontSize: 16,
                ),
              ),
            ],
          ),

        
      ),
    );
  }
}