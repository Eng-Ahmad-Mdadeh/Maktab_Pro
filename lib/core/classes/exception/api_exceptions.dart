
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';

class ApiException extends AppException {
  final String? errorKey;

  ApiException(super.message, {this.errorKey});

  @override
  String toString() => message;
}

class BadRequestException extends ApiException {
  BadRequestException(String message, {String? errorKey}) : super('BadRequestException: $message', errorKey: errorKey);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message, {String? errorKey}) : super('UnauthorizedException: $message', errorKey: errorKey);
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message, {String? errorKey}) : super('ForbiddenException: $message', errorKey: errorKey);
}

class NotFoundException extends ApiException {
  NotFoundException(String message, {String? errorKey}) : super('NotFoundException: $message', errorKey: errorKey);
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(String message, {String? errorKey})
      : super('InternalServerErrorException: $message', errorKey: errorKey);
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException() : super('لا يوجد اتصال بالانترنت');
}
