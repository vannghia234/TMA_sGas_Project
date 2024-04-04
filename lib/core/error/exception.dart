class APIServiceException implements Exception {}

// 5xx response status code
class ServerException implements APIServiceException {}

// 404 response status
class NotFoundException implements APIServiceException {}

// 401
class AuthorizationException implements APIServiceException {}

// 403
class ForbiddenException implements APIServiceException {}

// 400
class BadRequestException implements APIServiceException {
  String? data;
  String? statusCode;
  BadRequestException({this.statusCode, this.data});
}

//fail to parse data to model
class DataParsingException implements APIServiceException {}
