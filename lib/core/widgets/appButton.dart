import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/appColors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 65,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.cairo(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.background,
          )
        ),
      ),
    );
  }
}
