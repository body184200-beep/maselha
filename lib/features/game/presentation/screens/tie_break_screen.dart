import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/appColors.dart';
import '../helpers/game_config.dart';
import '../helpers/tie_break.dart';
import '../widgets/draw/tie_break_option.dart';
import '../widgets/game_shell.dart';
import 'tie_break_pick_screen.dart';

/// Shown when the teams are tied after the last round.
class TieBreakScreen extends StatelessWidget {
  final GameConfig config;

  const TieBreakScreen({super.key, required this.config});

  void _choose(BuildContext context, TieBreakMode mode) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TieBreakPickScreen(config: config, mode: mode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leaders = tiedLeaders(config.teams);

    return GameShell(
      onBack: () {}, // no going back to a finished game
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            Text(
              'تعادل!',
              style: GoogleFonts.cairo(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${leaders.map((t) => t.name).join(' و ')} '
                  'بنفس النقاط (${leaders.first.score})',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(fontSize: 16, color: AppColors.white),
            ),
            const SizedBox(height: 32),
            for (final mode in TieBreakMode.values)
              TieBreakOption(mode: mode, onTap: () => _choose(context, mode)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}