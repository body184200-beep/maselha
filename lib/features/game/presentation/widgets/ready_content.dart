import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appButton.dart';
import '../../../game_setup/data/models/team_model.dart';
import 'ready_actor_badge.dart';
import 'ready_illustration.dart';
import 'ready_team_pill.dart';

class ReadyContent extends StatelessWidget {
  final TeamModel team;
  final String actor;
  final int actingCount;
  final VoidCallback onStart;

  const ReadyContent({
    super.key,
    required this.team,
    required this.actor,
    required this.actingCount,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight - 24),
          child: IntrinsicHeight(child: _buildColumn()),
        ),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      children: [
        ReadyTeamPill(team: team),
        const SizedBox(height: 10),
        ReadyActorBadge(team: team, actor: actor, actingCount: actingCount),
        const Spacer(flex: 1),
        Text(
          'جاهز؟',
          style: GoogleFonts.cairo(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'اضغط على الزر لبدء الدور',
          style: GoogleFonts.cairo(fontSize: 16, color: AppColors.lightGray),
        ),
        const SizedBox(height: 32),
        ReadyIllustration(color: team.color),
        const Spacer(flex: 2),
        AppButton(text: 'جاهز!', onPressed: onStart),
        const SizedBox(height: 24),
      ],
    );
  }
}