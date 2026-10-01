import 'dart:math';

/// Picks who acts next for a team.
///
/// Fair rotation: only players with the fewest turns so far are eligible,
/// so nobody acts a second time before everyone has acted once. That also
/// keeps the "max 2 per player" rule whenever the number of turns allows it.
/// The previous actor is skipped when someone else is eligible, so the same
/// player never acts twice in a row.
String pickActor({
  required List<String> players,
  required Map<String, int> actingCount,
  String? previous,
  Random? random,
}) {
  assert(players.isNotEmpty, 'A team needs at least one player');
  int turns(String p) => actingCount[p] ?? 0;

  final fewest = players.map(turns).reduce(min);
  final candidates = players.where((p) => turns(p) == fewest).toList();
  if (candidates.length > 1) candidates.remove(previous);

  return candidates[(random ?? Random()).nextInt(candidates.length)];
}