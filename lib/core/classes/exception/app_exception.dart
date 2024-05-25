import 'dart:developer';

class AppException implements Exception {
  final String message;

  AppException(this.message) {
    log(message);
  }

  @override
  String toString() => 'AppException: $message';
}
