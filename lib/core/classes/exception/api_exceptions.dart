
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';

class ApiException extends AppException {
  ApiException(super.message);

  @override
  String toString() => message;
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super('BadRequestException: $message');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message)
      : super('UnauthorizedException: $message');
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super('ForbiddenException: $message');
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super('NotFoundException: $message');
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(String message)
      : super('InternalServerErrorException: $message');
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException() : super('لا يوجد اتصال بالانترنت');
}
