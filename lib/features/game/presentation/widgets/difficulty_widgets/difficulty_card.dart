import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';
import '../../../data/models/difficulty_model.dart';
import '../../helpers/difficulty_style.dart';
import 'difficulty_check.dart';

class DifficultyCard extends StatelessWidget {
  final DifficultyModel difficulty;
  final bool isSelected;
  final VoidCallback onTap;

  const DifficultyCard({
    super.key,
    required this.difficulty,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = difficultyColor(difficulty.id);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? accent.withValues(alpha: 0.18) : AppColors.navy,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? accent : Colors.transparent,
            width: 2.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: accent.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            _iconCircle(accent),
            const SizedBox(width: 16),
            Expanded(child: _texts(accent)),
            DifficultyCheck(isSelected: isSelected, color: accent),
          ],
        ),
      ),
    );
  }

  Widget _iconCircle(Color accent) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: isSelected ? 0.3 : 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(difficultyIcon(difficulty.id), color: accent, size: 28),
    );
  }

  Widget _texts(Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          difficulty.name,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? accent : AppColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          difficulty.description,
          style: GoogleFonts.cairo(fontSize: 14, color: AppColors.lightGray),
        ),
      ],
    );
  }
}