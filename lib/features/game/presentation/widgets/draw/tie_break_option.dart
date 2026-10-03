import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';
import '../../helpers/tie_break.dart';

/// A card for one tie-break choice (penalty / "ساعتي الجميلة").
class TieBreakOption extends StatelessWidget {
  final TieBreakMode mode;
  final VoidCallback onTap;

  const TieBreakOption({super.key, required this.mode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(mode.icon, color: AppColors.primary, size: 36),
              const SizedBox(width: 16),
              Expanded(child: _texts()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _texts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mode.label,
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        Text(
          mode.description,
          style: GoogleFonts.cairo(fontSize: 13, color: AppColors.lightGray),
        ),
      ],
    );
  }
}