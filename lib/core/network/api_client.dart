import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'failure.dart';

/// Thin wrapper over Dio. Every call returns Either<Failure, data>,
/// so callers never deal with try/catch or Dio types.
class ApiClient {
  static const _maxAttempts = 2;

  final Dio _dio;

  ApiClient({required String baseUrl, Map<String, String>? headers})
      : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json', ...?headers},
    ),
  );

  Future<Either<Failure, dynamic>> get(
      String path, {
        Map<String, dynamic>? query,
      }) =>
      _send(() => _dio.get(path, queryParameters: query));

  Future<Either<Failure, dynamic>> post(String path, {Object? data}) =>
      _send(() => _dio.post(path, data: data));

  Future<Either<Failure, dynamic>> _send(
      Future<Response<dynamic>> Function() request,
      ) async {
    for (var attempt = 1;; attempt++) {
      try {
        final response = await request();
        return Right(response.data);
      } on DioException catch (e) {
        // The request never reached the server, so trying again is safe.
        final notDelivered = e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.connectionError;
        if (notDelivered && attempt < _maxAttempts) {
          await Future<void>.delayed(const Duration(seconds: 1));
          continue;
        }
        debugPrint('API ${e.requestOptions.method} ${e.requestOptions.uri} '
            '-> ${e.type.name} ${e.message ?? e.error}');
        return Left(Failure.fromDio(e));
      } catch (e) {
        debugPrint('API unexpected error: $e');
        return const Left(Failure('حدث خطأ غير متوقع'));
      }
    }
  }
}