import 'package:flutter/material.dart';
import 'package:graduateproject/utils/colors.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData? icon2;
  final TextEditingController? controller;

  CustomField({
    super.key,
    required this.hintText,
    required this.icon,
    this.icon2,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorRadius: const Radius.circular(15),
      style: const TextStyle(
        fontSize: 16,
        color: Appcolor.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Appcolor.white,
          fontSize: 12,
        ),
        suffixIcon: icon2 != null
            ? Icon(
          icon2,
          color: Colors.white,
        )
            : null,
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        filled: true,
        fillColor: Appcolor.gray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
