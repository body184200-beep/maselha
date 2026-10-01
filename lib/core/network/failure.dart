import 'package:dio/dio.dart';

class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, [this.statusCode]);

  factory Failure.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure('انتهت مهلة الاتصال');
      case DioExceptionType.connectionError:
        return const Failure('لا يوجد اتصال بالإنترنت');
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        return Failure('خطأ من السيرفر ($code)', code);
      default:
        return const Failure('حدث خطأ غير متوقع');
    }
  }
}