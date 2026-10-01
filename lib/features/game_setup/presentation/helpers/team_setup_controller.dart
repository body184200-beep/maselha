import 'package:flutter/material.dart';

import '../../data/models/team_model.dart';
import 'team_colors.dart';

/// Holds teams + text controllers and validates them.
/// Validation methods return an error message, or null when valid.
class TeamSetupController {
  static const int maxPlayers = 5;
  static const int minPlayers = 2;

  final List<TeamModel> teams = [];
  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> playerControllers = [];

  TeamSetupController(int teamCount) {
    for (int i = 0; i < teamCount; i++) {
      final name =
      i < defaultTeamNames.length ? defaultTeamNames[i] : 'الفريق ${i + 1}';
      teams.add(TeamModel(
        id: 'team_$i',
        name: name,
        color: teamColors[i % teamColors.length],
        players: [],
      ));
      nameControllers.add(TextEditingController(text: name));
      playerControllers.add(TextEditingController());
    }
  }

  String? addPlayer(int teamIndex) {
    final name = playerControllers[teamIndex].text.trim();
    final players = teams[teamIndex].players;

    if (name.isEmpty) return 'يرجى كتابة اسم اللاعب أولاً';
    if (players.length >= maxPlayers) {
      return 'الحد الأقصى لكل فريق هو $maxPlayers لاعبين';
    }
    if (players.any((p) => p.toLowerCase() == name.toLowerCase())) {
      return 'اللاعب "$name" مضاف بالفعل في هذا الفريق';
    }
    players.add(name);
    playerControllers[teamIndex].clear();
    return null;
  }

  void deletePlayer(int teamIndex, int playerIndex) {
    teams[teamIndex].players.removeAt(playerIndex);
  }

  /// Colors stay unique: if another team already has [color], swap with it.
  void setColor(int teamIndex, Color color) {
    final team = teams[teamIndex];
    for (final other in teams) {
      if (other != team && other.color == color) other.color = team.color;
    }
    team.color = color;
  }

  String? validate() {
    // 1. Sync names from controllers
    for (int i = 0; i < teams.length; i++) {
      final entered = nameControllers[i].text.trim();
      if (entered.isEmpty) return 'يرجى كتابة اسم لـ الفريق ${i + 1}';
      teams[i].name = entered;
    }
    // 2. Unique team names
    final seen = <String>{};
    for (final team in teams) {
      if (!seen.add(team.name.toLowerCase())) {
        return 'يجب ألا تتكرر أسماء الفرق (الفريق "${team.name}" مكرر)';
      }
    }
    // 3. Minimum players per team
    for (final team in teams) {
      if (team.players.length < minPlayers) {
        return 'يجب إضافة لاعبين على الأقل في "${team.name}" '
            '(المضاف حالياً: ${team.players.length})';
      }
    }
    return null;
  }

  void dispose() {
    for (final c in [...nameControllers, ...playerControllers]) {
      c.dispose();
    }
  }
}