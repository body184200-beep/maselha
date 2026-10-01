import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/appColors.dart';
import '../../helpers/match_result.dart';

class ResultTeamRow extends StatelessWidget {
  final TeamRanking ranking;
  final bool showRank;

  const ResultTeamRow({
    super.key,
    required this.ranking,
    required this.showRank,
  });

  @override
  Widget build(BuildContext context) {
    final team = ranking.team;
    final highlight = ranking.isWinner;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: _nameAndRank(highlight)),
              _text('${team.score} نقطة', 20, FontWeight.bold,
                  highlight ? AppColors.primary : AppColors.white),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: ranking.ratio,
              minHeight: 8,
              backgroundColor: AppColors.background.withValues(alpha: 0.6),
              valueColor: AlwaysStoppedAnimation<Color>(
                highlight ? AppColors.primary : team.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameAndRank(bool highlight) {
    return Row(
      children: [
        CircleAvatar(radius: 8, backgroundColor: ranking.team.color),
        const SizedBox(width: 10),
        Flexible(
          child: _text(ranking.team.name, 17, FontWeight.bold, AppColors.white),
        ),
        if (showRank) ...[
          const SizedBox(width: 8),
          _text(rankBadge(ranking.rank), 12, FontWeight.w600,
              highlight ? AppColors.primary : AppColors.lightGray),
        ],
      ],
    );
  }

  Widget _text(String text, double size, FontWeight weight, Color color) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.cairo(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}