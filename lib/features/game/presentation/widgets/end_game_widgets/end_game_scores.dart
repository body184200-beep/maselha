import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';
import '../../../../game_setup/data/models/team_model.dart';

class EndGameScores extends StatelessWidget {
  final List<TeamModel> teams;

  const EndGameScores({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: teams.map(_row).toList()),
    );
  }

  Widget _row(TeamModel t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            CircleAvatar(radius: 6, backgroundColor: t.color),
            const SizedBox(width: 8),
            _text(t.name, AppColors.white),
          ]),
          _text('${t.score} نقطة', AppColors.primary),
        ],
      ),
    );
  }

  Widget _text(String text, Color color) => Text(
    text,
    style: GoogleFonts.cairo(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
  );
}