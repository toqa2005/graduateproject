import 'package:flutter/material.dart';
import '../../colors/Appcolors.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData? icon2;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? onIcon2Pressed;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.icon2,
    this.obscureText = false,
    this.onIcon2Pressed,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: 1,
      autocorrect: false,
      enableSuggestions: !obscureText,
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
            color: Appcolor.lightgray,
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
