import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';
import 'result_trophy.dart';

class ResultHeader extends StatelessWidget {
  final String headline;

  const ResultHeader({super.key, required this.headline});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ResultTrophy(),
        const SizedBox(height: 18),
        Text(
          'انتهت اللعبة!',
          style: GoogleFonts.cairo(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          headline,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}