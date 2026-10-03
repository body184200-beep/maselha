import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Failure {
  final String message;
  final int? statusCode;

  /// The technical reason. Only shown in debug builds (see [displayMessage]).
  final String? details;

  const Failure(this.message, [this.statusCode, this.details]);

  /// What the screens show: the friendly message, plus the technical reason
  /// while developing so the real cause is visible on the device.
  String get displayMessage =>
      kDebugMode && details != null ? '$message\n($details)' : message;

  factory Failure.fromDio(DioException e) {
    final details = '${e.type.name}: ${e.message ?? e.error}';
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure('انتهت مهلة الاتصال', null, details);
      case DioExceptionType.connectionError:
        return Failure('لا يوجد اتصال بالإنترنت', null, details);
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        return Failure('خطأ من السيرفر ($code)', code, details);
      default:
        return Failure('حدث خطأ غير متوقع', null, details);
    }
  }
}