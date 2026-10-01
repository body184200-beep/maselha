import '../../data/models/category_model.dart';
import '../../data/models/difficulty_model.dart';
import '../../data/models/word_model.dart';
import '../../data/sources/game_data_source.dart';
import '../widgets/word_history.dart';

class WordDeck {
  final List<WordModel> words;
  final List<CategoryModel> categories;
  final WordHistory _history;
  int _index = 0;

  WordDeck({
    required this.words,
    required this.categories,
    WordHistory? history,
  }) : _history = history ?? WordHistory.instance {
    _markShown();
  }

  /// Unseen words come first (shuffled), then already-seen ones (shuffled),
  /// so a turn never runs out and a new turn doesn't start with an old word.
  factory WordDeck.load({
    required GameDataSource dataSource,
    required List<CategoryModel> categories,
    required DifficultyModel difficulty,
    bool newGame = false,
  }) {
    final history = WordHistory.instance;
    if (newGame) history.clear();

    final all = dataSource.getWords(
      categoryIds: categories.map((c) => c.id).toList(),
      difficultyId: difficulty.id,
    );
    final fresh = all.where((w) => !history.contains(w.word)).toList()
      ..shuffle();
    final seen = all.where((w) => history.contains(w.word)).toList()
      ..shuffle();
    return WordDeck(words: [...fresh, ...seen], categories: categories);
  }

  bool get isEmpty => words.isEmpty;

  String get currentText => words.isNotEmpty && _index < words.length
      ? words[_index].word
      : 'لا توجد كلمات';

  CategoryModel? get currentCategory {
    if (words.isEmpty || _index >= words.length) return null;
    final categoryId = words[_index].categoryId;
    for (final cat in categories) {
      if (cat.id == categoryId) return cat;
    }
    return null;
  }

  void next() {
    if (words.isEmpty) return;
    _index = (_index + 1) % words.length;
    _markShown();
  }

  void _markShown() {
    if (words.isNotEmpty) _history.add(words[_index].word);
  }
}