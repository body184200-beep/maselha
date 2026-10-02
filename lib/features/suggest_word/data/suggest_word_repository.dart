import 'package:dartz/dartz.dart';

import '../../../core/network/failure.dart';
import '../../game/data/sources/game_cache.dart';
import '../../game/data/sources/maselha_api.dart';
import 'word_category.dart';

class SuggestWordRepository {
  final MaselhaApi _api;
  final GameCache _cache;

  const SuggestWordRepository(this._api, this._cache);

  /// Network first (and saved), the last saved copy when offline.
  Future<Either<Failure, List<WordCategory>>> categories() async {
    final result = await _api.categories();
    return result.fold(
          (failure) {
        final cached = _parse(_cache.categories);
        return cached == null ? Left(failure) : Right(cached);
      },
          (json) {
        final parsed = _parse(json);
        if (parsed == null) return const Left(Failure('رد غير متوقع من السيرفر'));
        _cache.saveCategories(json);
        return Right(parsed);
      },
    );
  }

  Future<Either<Failure, Unit>> submit({
    required String text,
    required int categoryId,
  }) async {
    final result = await _api.addSuggestedWord(
      text: text,
      categoryId: categoryId,
    );
    return result.fold(
          (failure) => Left(
        failure.statusCode == 400
            ? const Failure('تأكد من كتابة الكلمة واختيار الفئة', 400)
            : failure,
      ),
          (_) => const Right(unit),
    );
  }

  List<WordCategory>? _parse(dynamic json) {
    try {
      return (json as List)
          .map((e) => WordCategory.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }
}