import '../../../game_setup/data/models/team_model.dart';

class TeamRanking {
  final TeamModel team;
  final int rank; // teams with equal scores share the same rank
  final bool isWinner;
  final double ratio; // score bar fill, 0.05 - 1.0

  const TeamRanking({
    required this.team,
    required this.rank,
    required this.isWinner,
    required this.ratio,
  });
}

class MatchResult {
  final List<TeamRanking> rankings; // sorted by score, highest first
  final List<TeamModel> winners;
  final int topScore;

  const MatchResult._(this.rankings, this.winners, this.topScore);

  factory MatchResult.from(List<TeamModel> teams) {
    final sorted = List<TeamModel>.from(teams)
      ..sort((a, b) => b.score.compareTo(a.score));
    final top = sorted.isEmpty ? 0 : sorted.first.score;
    final maxScore = top > 0 ? top : 1;
    bool isTop(TeamModel t) => top > 0 && t.score == top;

    return MatchResult._(
      [
        for (final t in sorted)
          TeamRanking(
            team: t,
            rank: 1 + sorted.where((o) => o.score > t.score).length,
            isWinner: isTop(t),
            ratio: (t.score / maxScore).clamp(0.05, 1.0).toDouble(),
          ),
      ],
      sorted.where(isTop).toList(),
      top,
    );
  }

  /// Nobody scored, so there is no winner and no meaningful ranking.
  bool get noScores => topScore <= 0;

  String get headline {
    if (noScores) return 'تعادل — لم يسجل أي فريق نقاطًا';
    if (winners.length == 1) return '🏆 ${winners.first.name} فاز بالبطولة! 🏆';
    return '🤝 تعادل بين ${winners.map((t) => t.name).join(' و ')}';
  }
}

String rankBadge(int rank) {
  switch (rank) {
    case 1:
      return '🥇 المركز الأول';
    case 2:
      return '🥈 المركز الثاني';
    case 3:
      return '🥉 المركز الثالث';
    default:
      return 'المركز $rank';
  }
}