import '../../../game_setup/data/models/team_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/difficulty_model.dart';
import '../../data/sources/game_data_source.dart';

/// Everything needed to start (or restart) a game.
class GameConfig {
  final List<TeamModel> teams;
  final List<CategoryModel> categories;
  final DifficultyModel difficulty;
  final GameDataSource dataSource;
  final int totalRounds;

  const GameConfig({
    required this.teams,
    required this.categories,
    required this.difficulty,
    required this.dataSource,
    required this.totalRounds,
  });

  /// Same teams (names, colors, players) with scores and actor history reset.
  GameConfig withFreshTeams() => GameConfig(
    teams: [
      for (final t in teams)
        TeamModel(
          id: t.id,
          name: t.name,
          color: t.color,
          players: List<String>.from(t.players),
        ),
    ],
    categories: categories,
    difficulty: difficulty,
    dataSource: dataSource,
    totalRounds: totalRounds,
  );
}