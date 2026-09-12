import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData? icon2;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? onIcon2Pressed;
  final TextInputType? keyboardType;

  const CustomField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.icon2,
    this.obscureText = false,
    this.onIcon2Pressed,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Appcolor.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Appcolor.gray,
        ),
        prefixIcon: Icon(
          icon,
          color: Appcolor.yellow,
        ),
        suffixIcon: icon2 != null
            ? IconButton(
          onPressed: onIcon2Pressed,
          icon: Icon(
            icon2,
            color: Appcolor.yellow,
          ),
        )
            : null,
        filled: true,
        fillColor: Appcolor.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Appcolor.gray,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Appcolor.gray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Appcolor.yellow,
            width: 2,
          ),
        ),
      ),
    );
  }
}