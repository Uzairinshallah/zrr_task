import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final double borderRadius;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;

  const CustomTextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.borderRadius = 8.0,
    this.textStyle,
    this.hintStyle,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
