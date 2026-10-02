import 'package:dartz/dartz.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/failure.dart';

/// The network side of the game: one method per endpoint, raw JSON out.
/// Turning JSON into models is done elsewhere, so this stays tiny.
class MaselhaApi {
  final ApiClient _client;

  const MaselhaApi(this._client);

  /// [{id, name, description}]
  Future<Either<Failure, dynamic>> categories() =>
      _client.get(ApiEndpoints.categories);

  /// [{id, name, time_limit}]
  Future<Either<Failure, dynamic>> difficultyLevels() =>
      _client.get(ApiEndpoints.difficultyLevels);

  /// One random word: {id, text, category: {id, name, description}}.
  /// The docs list no filters, so it can't be limited by category or level.
  Future<Either<Failure, dynamic>> randomWord() =>
      _client.get(ApiEndpoints.randomWord);

  /// Both fields are required, otherwise the server answers 400.
  Future<Either<Failure, dynamic>> addSuggestedWord({
    required String text,
    required int categoryId,
  }) =>
      _client.post(
        ApiEndpoints.addSuggestedWord,
        data: {'text': text, 'category': categoryId},
      );
}