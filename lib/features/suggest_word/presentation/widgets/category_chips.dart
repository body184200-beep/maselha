import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../data/word_category.dart';

class CategoryChips extends StatelessWidget {
  final List<WordCategory> categories;
  final int? selectedId;
  final ValueChanged<int> onSelect;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final c in categories)
          ChoiceChip(
            label: Text(
              c.name,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                color: selectedId == c.id
                    ? AppColors.background
                    : AppColors.white,
              ),
            ),
            selected: selectedId == c.id,
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.navy,
            onSelected: (_) => onSelect(c.id),
          ),
      ],
    );
  }
}