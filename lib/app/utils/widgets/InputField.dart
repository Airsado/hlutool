/// @Author Airsado
/// @Date 2023-09-14 21:08
/// @Version 1.0
/// @Description 输入框

import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.hintText,
      this.controller,
      this.prefixIcon,
      this.focusedColor = Colors.blue,
      this.enabledColor = Colors.grey,
      this.obscureText = false});

  final String hintText;
  final Color focusedColor;
  final Color enabledColor;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? prefixIcon;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            // suffixIcon: const Icon(Icons.remove_red_eye_outlined),
            prefixIcon: widget.prefixIcon,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.focusedColor)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.enabledColor)),
            hintText: widget.hintText,
            border: const OutlineInputBorder()));
  }
}
