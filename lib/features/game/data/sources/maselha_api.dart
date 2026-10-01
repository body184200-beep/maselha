
import 'package:dartz/dartz.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/failure.dart';

/// The network side of the game: one method per endpoint, raw JSON out.
/// Turning JSON into models is done elsewhere, so this stays tiny.
class MaselhaApi {
  final ApiClient _client;

  const MaselhaApi(this._client);

  Future<Either<Failure, dynamic>> categories() =>
      _client.get(ApiEndpoints.categories);

  Future<Either<Failure, dynamic>> difficultyLevels() =>
      _client.get(ApiEndpoints.difficultyLevels);

  /// [query] holds the filters (category / difficulty) once we know the
  /// exact parameter names from the docs.
  Future<Either<Failure, dynamic>> randomWord({Map<String, dynamic>? query}) =>
      _client.get(ApiEndpoints.randomWord, query: query);

  /// [body] is the JSON the docs expect for a suggested word.
  Future<Either<Failure, dynamic>> addSuggestedWord(
      Map<String, dynamic> body,
      ) =>
      _client.post(ApiEndpoints.addSuggestedWord, data: body);
}