import 'package:flutter/material.dart';

import '../../../../../core/theme/appColors.dart';
import '../../helpers/match_result.dart';
import 'result_team_row.dart';

/// Scoreboard card, like in video games.
class ResultScoreboard extends StatelessWidget {
  final MatchResult result;

  const ResultScoreboard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final rankings = result.rankings;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < rankings.length; i++) ...[
            ResultTeamRow(ranking: rankings[i], showRank: !result.noScores),
            if (i < rankings.length - 1)
              Divider(
                color: AppColors.lightGray.withValues(alpha: 0.1),
                height: 1,
              ),
          ],
        ],
      ),
    );
  }
}