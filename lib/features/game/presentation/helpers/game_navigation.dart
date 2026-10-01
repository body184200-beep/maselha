import 'package:flutter/material.dart';

import '../../../game_setup/data/models/team_model.dart';
import '../screens/category_selection_screen.dart';
import '../screens/ready_screen.dart';
import '../screens/result_screen.dart';
import 'game_config.dart';

bool isFinalTurn(List<TeamModel> teams, int teamIndex, int round, int total) =>
    teamIndex == teams.length - 1 && round >= total;

void goToResult(BuildContext context, GameConfig config) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => ResultScreen(config: config)),
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

/// After time is up: next team/round -> ReadyScreen, or final -> ResultScreen.
void goToNextTurn(
    BuildContext context,
    GameConfig config, {
      required int teamIndex,
      required int round,
    }) {
  final teams = config.teams;
  if (isFinalTurn(teams, teamIndex, round, config.totalRounds)) {
    goToResult(context, config);
    return;
  }
  final isLastTeam = teamIndex == teams.length - 1;
  final nextTeamIndex = isLastTeam ? 0 : teamIndex + 1;
  final nextRound = isLastTeam ? round + 1 : round;

  // Pick random actor for the next team (max 2 times per player)
  teams[nextTeamIndex].pickRandomActor();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => ReadyScreen(
        teams: teams,
        selectedCategories: config.categories,
        difficulty: config.difficulty,
        dataSource: config.dataSource,
        currentTeamIndex: nextTeamIndex,
        currentRound: nextRound,
        totalRounds: config.totalRounds,
      ),
    ),
  );
}