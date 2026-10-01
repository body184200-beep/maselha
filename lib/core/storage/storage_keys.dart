/// Every key we save locally. Bump the suffix (v1 -> v2) when the saved
/// format changes, so old data is ignored instead of crashing the parser.
class StorageKeys {
  StorageKeys._();

  static const categories = 'cache_categories_v1';
  static const difficultyLevels = 'cache_difficulty_levels_v1';
  static const words = 'cache_words_v1';
}