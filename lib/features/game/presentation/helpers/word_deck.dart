import '../../data/models/category_model.dart';
import '../../data/models/difficulty_model.dart';
import '../../data/models/word_model.dart';
import '../../data/sources/game_data_source.dart';

class WordDeck {
  final List<WordModel> words;
  final List<CategoryModel> categories;
  int _index = 0;

  WordDeck({required this.words, required this.categories});

  factory WordDeck.load({
    required GameDataSource dataSource,
    required List<CategoryModel> categories,
    required DifficultyModel difficulty,
  }) =>
      WordDeck(
        categories: categories,
        words: dataSource.getWords(
          categoryIds: categories.map((c) => c.id).toList(),
          difficultyId: difficulty.id,
        ),
      );

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
    if (words.isNotEmpty) _index = (_index + 1) % words.length;
  }
}