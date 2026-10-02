import '../../features/game/data/sources/game_cache.dart';
import '../../features/game/data/sources/game_data_source.dart';
import '../../features/game/data/sources/local_game_data_source.dart';
import '../../features/game/data/sources/maselha_api.dart';
import '../../features/suggest_word/data/suggest_word_repository.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../storage/local_storage.dart';

/// Created once in main(); screens read what they need from here.
class AppDependencies {
  AppDependencies._();

  static late final LocalStorage storage;
  static late final ApiClient apiClient;
  static late final MaselhaApi maselhaApi;
  static late final GameCache gameCache;
  static late final SuggestWordRepository suggestWordRepository;

  /// The game keeps using the bundled words (see the notes on the API).
  static late final GameDataSource gameDataSource;

  static Future<void> init() async {
    storage = LocalStorage();
    await storage.init();

    apiClient = ApiClient(baseUrl: ApiEndpoints.baseUrl);
    maselhaApi = MaselhaApi(apiClient);
    gameCache = GameCache(storage);
    suggestWordRepository = SuggestWordRepository(maselhaApi, gameCache);
    gameDataSource = const LocalGameDataSource();
  }
}