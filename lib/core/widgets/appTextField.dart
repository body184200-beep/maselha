import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/appColors.dart';

class Apptextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const Apptextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.background),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.purple),
        ),
      ),
      style: const TextStyle(color: AppColors.white),
      cursorColor: AppColors.primary,
      cursorWidth: 2,
      cursorHeight: 20,
      cursorRadius: const Radius.circular(5),
      cursorOpacityAnimates: true,
    );
  }
}
