class InternetConnectionException implements Exception {}

class TimeOutException implements Exception {}

class ServerException implements Exception {}

class ExceptionWithMessage implements Exception {
  final String message;

  ExceptionWithMessage({required this.message});
}

class AuthorizationException implements Exception {
  final String? message;

  AuthorizationException({this.message});
}

class InvalidCredentialsException implements Exception {
  final String? message;

  InvalidCredentialsException({this.message});
}

class BadRequestException implements Exception {
  final String? message;

  BadRequestException({this.message});
}

class ForbiddenException implements Exception {}

class NoDataException implements Exception {}

class UnknownException implements Exception {}
