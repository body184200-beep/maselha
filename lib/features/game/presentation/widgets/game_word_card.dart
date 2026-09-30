import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../data/models/category_model.dart';

class GameWordCard extends StatelessWidget {
  final CategoryModel? category;
  final String word;

  const GameWordCard({super.key, required this.category, required this.word});

  @override
  Widget build(BuildContext context) {
    final cat = category;
    return Container(
      width: double.infinity,
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (cat != null)
            Column(children: [
              Text(
                cat.name,
                style: GoogleFonts.cairo(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: cat.color,
                ),
              ),
              const SizedBox(height: 4),
              Icon(cat.icon, color: cat.color, size: 28),
            ])
          else
            const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              word,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: AppColors.background,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}