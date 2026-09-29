import 'package:flutter/material.dart';
import '../../colors/Appcolors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color colortext;
  final Color colorbutton;
  final VoidCallback? onPressed;
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
          disabledBackgroundColor: colorbutton.withOpacity(.45),
          disabledForegroundColor: colortext.withOpacity(.45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: hasBorder
                ? const BorderSide(
              color: Appcolor.yellow,
              width: 2,
            )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: colortext,
                size: 30,
              ),
              const SizedBox(width: 5),
            ],
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
