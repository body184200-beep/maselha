import 'dart:math';

import '../../../game_setup/data/models/team_model.dart';

/// Whose turn it is: the round, the team, and the player's index in it.
class GameTurn {
  final int round;
  final int teamIndex;
  final int playerIndex;

  const GameTurn({this.round = 1, this.teamIndex = 0, this.playerIndex = 0});

  bool get isFirst => round == 1 && teamIndex == 0 && playerIndex == 0;
}

/// One round: player 1 of every team, then player 2 of every team, and so
/// on. Teams alternate and each player acts exactly once per round.
/// (Team 1: A, B / Team 2: C, D  ->  A, C, B, D)
List<GameTurn> roundTurns(List<TeamModel> teams, int round) {
  final most = teams.map((t) => t.players.length).fold(0, max);
  return [
    for (var p = 0; p < most; p++)
      for (var t = 0; t < teams.length; t++)
        if (p < teams[t].players.length)
          GameTurn(round: round, teamIndex: t, playerIndex: p),
  ];
}

/// The turn after [turn], or null when the last round is over.
GameTurn? nextTurn(List<TeamModel> teams, GameTurn turn, int totalRounds) {
  final turns = roundTurns(teams, turn.round);
  final i = turns.indexWhere(
        (t) => t.teamIndex == turn.teamIndex && t.playerIndex == turn.playerIndex,
  );
  if (i >= 0 && i + 1 < turns.length) return turns[i + 1];
  if (turn.round >= totalRounds) return null;
  return roundTurns(teams, turn.round + 1).first;
}