
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

// Network Exceptions
class NetworkException extends ApiException {
  NetworkException(String message) : super(message);
}

class NetworkTimeoutException extends NetworkException {
  NetworkTimeoutException(String message) : super(message);
}

// Server Exceptions
class ServerException extends ApiException {
  ServerException(String message) : super(message);
}

// Authentication Exceptions
class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message);
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super(message);
}

// Other Exceptions
class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message);
}

class RateLimitedException extends ApiException {
  RateLimitedException(String message) : super(message);
}

class UnexpectedException extends ApiException {
  UnexpectedException(String message) : super(message);
}