import '../../../../core/storage/local_storage.dart';
import '../../../../core/storage/storage_keys.dart';

/// The storage side of the game: saves the last good API responses, so the
/// app works offline and starts instantly. Stores raw JSON, like [MaselhaApi]
/// returns it.
class GameCache {
  final LocalStorage _storage;

  const GameCache(this._storage);

  dynamic get categories => _storage.getJson(StorageKeys.categories);
  dynamic get difficultyLevels => _storage.getJson(StorageKeys.difficultyLevels);
  dynamic get words => _storage.getJson(StorageKeys.words);

  Future<void> saveCategories(Object? json) =>
      _storage.setJson(StorageKeys.categories, json);

  Future<void> saveDifficultyLevels(Object? json) =>
      _storage.setJson(StorageKeys.difficultyLevels, json);

  Future<void> saveWords(Object? json) =>
      _storage.setJson(StorageKeys.words, json);
}