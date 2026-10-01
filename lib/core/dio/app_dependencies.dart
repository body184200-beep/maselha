import '../../features/game/data/sources/game_cache.dart';
import '../../features/game/data/sources/game_data_source.dart';
import '../../features/game/data/sources/local_game_data_source.dart';
import '../../features/game/data/sources/maselha_api.dart';
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

  /// Still the bundled data. It switches to the API-backed source once the
  /// words flow (random-word) is wired, and nothing else has to change.
  static late final GameDataSource gameDataSource;

  static Future<void> init() async {
    storage = LocalStorage();
    await storage.init();

    apiClient = ApiClient(baseUrl: ApiEndpoints.baseUrl);
    maselhaApi = MaselhaApi(apiClient);
    gameCache = GameCache(storage);
    gameDataSource = const LocalGameDataSource();
  }
}