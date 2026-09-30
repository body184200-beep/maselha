import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import 'team_count_icon.dart';

class TeamCountHeader extends StatelessWidget {
  const TeamCountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TeamCountIcon(),
        const SizedBox(height: 20),
        Text(
          'اختيار عدد الفرق',
          style: GoogleFonts.cairo(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            'اختر من 2 إلى 4 فرق لبدء التحدي',
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}