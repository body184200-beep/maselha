import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../game_setup/data/models/team_model.dart';

/// Shows the acting player and how many times they acted (max 2).
class ReadyActorBadge extends StatelessWidget {
  final TeamModel team;
  final String actor;
  final int actingCount;

  const ReadyActorBadge({
    super.key,
    required this.team,
    required this.actor,
    required this.actingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: team.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: team.color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.theater_comedy_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              'الممثل: $actor',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _CountChip(text: '$actingCount / 2'),
        ],
      ),
    );
  }
}

class _CountChip extends StatelessWidget {
  final String text;

  const _CountChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }
}