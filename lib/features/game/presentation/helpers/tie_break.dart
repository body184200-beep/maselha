import 'dart:math';

import 'package:flutter/material.dart';

import '../../../game_setup/data/models/team_model.dart';
import 'game_config.dart';
import 'game_controller.dart';
import 'word_deck.dart';

enum TieBreakMode {
  penalty(
    'ضربة جزاء 🎯',
    'لاعب عشوائي من كل فريق يمثل كلمة واحدة فقط، والإجابة الصحيحة بـ 50 نقطة',
    Icons.sports_score_rounded,
    points: 50,
    extraSeconds: 0,
    singleWord: true,
  ),
  bonusTime(
    'ساعتي الجميلة ⏱️',
    'لاعب عشوائي من كل فريق يلعب دوره كاملًا ومعاه 90 ثانية زيادة',
    Icons.timer_rounded,
    points: 10,
    extraSeconds: 90,
    singleWord: false,
  );

  const TieBreakMode(
      this.label,
      this.description,
      this.icon, {
        required this.points,
        required this.extraSeconds,
        required this.singleWord,
      });

  final String label;
  final String description;
  final IconData icon;
  final int points;
  final int extraSeconds;
  final bool singleWord;
}

/// A player picked by the wheel to play the tie-break for their team.
class TieBreakParticipant {
  final int teamIndex;
  final String player;

  const TieBreakParticipant({required this.teamIndex, required this.player});
}

/// Teams sharing the top score, or empty when there is a single leader.
List<TeamModel> tiedLeaders(List<TeamModel> teams) {
  if (teams.length < 2) return [];
  final top = teams.map((t) => t.score).reduce(max);
  final leaders = teams.where((t) => t.score == top).toList();
  return leaders.length > 1 ? leaders : [];
}

/// The words still come from [GameConfig.dataSource], like any other turn.
GameController createTieBreakController(
    GameConfig config,
    TieBreakParticipant who,
    TieBreakMode mode,
    ) {
  final team = config.teams[who.teamIndex];
  team.currentActor = who.player;
  return GameController(
    team: team,
    deck: WordDeck.load(
      dataSource: config.dataSource,
      categories: config.categories,
      difficulty: config.difficulty,
    ),
    seconds: config.difficulty.durationSeconds + mode.extraSeconds,
    pointsPerWord: mode.points,
    singleWord: mode.singleWord,
  );
}