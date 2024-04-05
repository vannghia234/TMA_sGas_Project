class APIServiceException implements Exception {}

// 5xx response status code
class ServerException implements APIServiceException {}

// 401
class AuthorizationException implements APIServiceException {}

// 403
class ForbiddenException implements APIServiceException {}

// 400
class BadRequestException implements APIServiceException {}

//fail to parse data to model
class DataParsingException implements APIServiceException {}
