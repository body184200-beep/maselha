import 'package:flutter/material.dart';

import '../../helpers/game_config.dart';
import '../../helpers/match_result.dart';
import 'result_actions.dart';
import 'result_header.dart';
import 'result_scoreboard.dart';

/// Scrolls on small screens; otherwise fills the screen and spaces evenly.
class ResultBody extends StatelessWidget {
  final MatchResult result;
  final GameConfig config;

  const ResultBody({super.key, required this.result, required this.config});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth - 48,
            minHeight: constraints.maxHeight - 32,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                const Spacer(flex: 1),
                ResultHeader(headline: result.headline),
                const SizedBox(height: 28),
                ResultScoreboard(result: result),
                const Spacer(flex: 2),
                ResultActions(config: config),
              ],
            ),
          ),
        ),
      ),
    );
  }
}