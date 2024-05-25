import 'package:maktab/core/classes/exception/app_exception.dart';

class ServerException extends AppException {
  ServerException(String message) : super(message);
}

class CacheException extends AppException {
  CacheException(String message) : super(message);
}

class ConversionException extends AppException {
  ConversionException(String message) : super('ConversionException: $message');
}
