import 'package:flutter/material.dart';

import '../screens/category_selection_screen.dart';
import '../screens/ready_screen.dart';
import '../screens/result_screen.dart';
import '../screens/tie_break_screen.dart';
import 'game_config.dart';
import 'game_turn.dart';
import 'tie_break.dart';

void goToResult(BuildContext context, GameConfig config) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => ResultScreen(config: config)),
  );
}

/// All rounds are over (or a tie-break just ended): a tie goes to the
/// tie-break, anything else to the final result.
void goAfterRounds(BuildContext context, GameConfig config) {
  if (tiedLeaders(config.teams).isEmpty) {
    goToResult(context, config);
    return;
  }
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => TieBreakScreen(config: config)),
  );
}

/// Rematch: same teams (scores reset), same categories and difficulty.
void goToRematch(BuildContext context, GameConfig config) {
  final fresh = config.withFreshTeams();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => ReadyScreen(
        teams: fresh.teams,
        selectedCategories: fresh.categories,
        difficulty: fresh.difficulty,
        dataSource: fresh.dataSource,
        totalRounds: fresh.totalRounds,
      ),
    ),
        (route) => route.isFirst,
  );
}

/// Same teams (scores reset), but categories and difficulty are chosen again.
void goToChangeSettings(BuildContext context, GameConfig config) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => CategorySelectionScreen(
        teams: config.withFreshTeams().teams,
        dataSource: config.dataSource,
      ),
    ),
        (route) => route.isFirst,
  );
}

/// After a turn ends: the next player's ready screen, or, when the last
/// round is over, the tie-break / final result.
void goToNextTurn(BuildContext context, GameConfig config, GameTurn current) {
  final next = nextTurn(config.teams, current, config.totalRounds);
  if (next == null) {
    goAfterRounds(context, config);
    return;
  }
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => ReadyScreen(
        teams: config.teams,
        selectedCategories: config.categories,
        difficulty: config.difficulty,
        dataSource: config.dataSource,
        currentTeamIndex: next.teamIndex,
        currentPlayerIndex: next.playerIndex,
        currentRound: next.round,
        totalRounds: config.totalRounds,
      ),
    ),
  );
}