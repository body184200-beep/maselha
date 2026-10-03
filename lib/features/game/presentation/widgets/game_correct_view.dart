import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appButton.dart';
import 'game_correct_badges.dart';

// Screen 8: after a correct guess
class GameCorrectView extends StatelessWidget {
  final int points;
  final String nextLabel;
  final VoidCallback onNext;

  const GameCorrectView({
    super.key,
    required this.points,
    required this.nextLabel,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(flex: 1),
          const CheckBadge(),
          const SizedBox(height: 28),
          Text(
            'كلمة صحيحة!',
            style: GoogleFonts.cairo(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 12),
          PointsBadge(points: points),
          const Spacer(flex: 2),
          AppButton(text: nextLabel, onPressed: onNext),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}