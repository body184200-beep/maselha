/// Words already shown in the current game, so later turns don't start
/// with words the players have already seen.
class WordHistory {
  WordHistory._();

  static final WordHistory instance = WordHistory._();

  final Set<String> _shown = {};

  bool contains(String word) => _shown.contains(word);

  void add(String word) => _shown.add(word);

  void clear() => _shown.clear();
}