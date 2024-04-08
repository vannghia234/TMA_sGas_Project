import 'package:sgas/core/error/exception.dart';

abstract class Failure {}

class ServerFailure extends Failure {}

class AuthorizationFailure extends Failure {}

class ForbiddenFailure extends Failure {}

class BadRequestFailure extends Failure {
  String? data;
  int? statusCode;
  BadRequestFailure({this.statusCode, this.data});
}

class NotFoundFailure extends Failure {}

class DataParsingFailure extends Failure {}

Failure convertExceptionToFailure(Object exception) {
  if (exception is ServerException) return ServerFailure();
  if (exception is AuthorizationException) return AuthorizationFailure();
  if (exception is ForbiddenException) return ForbiddenFailure();
  if (exception is BadRequestException) {
    return BadRequestFailure(
        statusCode: exception.statusCode, data: exception.data);
  }
  if (exception is NotFoundException) return NotFoundFailure();
  return DataParsingFailure();
}
