import 'package:flutter/material.dart';

import '../../../game_setup/data/models/team_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/difficulty_model.dart';
import '../../data/sources/game_data_source.dart';
import '../screens/ready_screen.dart';
import '../screens/result_screen.dart';

bool isFinalTurn(List<TeamModel> teams, int teamIndex, int round, int total) =>
    teamIndex == teams.length - 1 && round >= total;

void goToResult(BuildContext context, List<TeamModel> teams) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => ResultScreen(teams: teams)),
  );
}

/// After time is up: next team/round -> ReadyScreen, or final -> ResultScreen.
void goToNextTurn(
    BuildContext context, {
      required List<TeamModel> teams,
      required List<CategoryModel> categories,
      required DifficultyModel difficulty,
      required GameDataSource dataSource,
      required int teamIndex,
      required int round,
      required int totalRounds,
    }) {
  if (isFinalTurn(teams, teamIndex, round, totalRounds)) {
    goToResult(context, teams);
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
        selectedCategories: categories,
        difficulty: difficulty,
        dataSource: dataSource,
        currentTeamIndex: nextTeamIndex,
        currentRound: nextRound,
        totalRounds: totalRounds,
      ),
    ),
  );
}