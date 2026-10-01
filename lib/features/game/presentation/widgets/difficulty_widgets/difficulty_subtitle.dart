import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';

class DifficultySubtitle extends StatelessWidget {
  const DifficultySubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          'حدد وقت وتحدي الجولة',
          style: GoogleFonts.cairo(fontSize: 14, color: AppColors.lightGray),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}