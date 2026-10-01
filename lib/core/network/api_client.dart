import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failure.dart';

/// Thin wrapper over Dio. Every call returns Either<Failure, data>,
/// so callers never deal with try/catch or Dio types.
class ApiClient {
  final Dio _dio;

  ApiClient({required String baseUrl, Map<String, String>? headers})
      : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
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
    try {
      final response = await request();
      return Right(response.data);
    } on DioException catch (e) {
      return Left(Failure.fromDio(e));
    } catch (_) {
      return const Left(Failure('حدث خطأ غير متوقع'));
    }
  }
}