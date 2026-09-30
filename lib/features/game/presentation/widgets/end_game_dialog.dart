import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../game_setup/data/models/team_model.dart';
import 'end_game_actions.dart';
import 'end_game_scores.dart';

void showEndGameDialog(
    BuildContext context,
    List<TeamModel> teams,
    VoidCallback onConfirm,
    ) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: AppColors.navy,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _Header(),
              const SizedBox(height: 20),
              EndGameScores(teams: teams),
              const SizedBox(height: 24),
              EndGameActions(
                onConfirm: () {
                  Navigator.pop(dialogContext);
                  onConfirm();
                },
                onCancel: () => Navigator.pop(dialogContext),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.flag_rounded,
            color: Colors.redAccent,
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'إنهاء اللعبة؟',
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'هل اتفق الفريقان على إنهاء اللعبة وعرض النتيجة الحالية؟',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(fontSize: 14, color: AppColors.lightGray),
        ),
      ],
    );
  }
}