/// Base exception class for the NBI application.
class AppException implements Exception {
  final String message;
  final String? prefix;
  final int? code;

  const AppException(this.message, {this.prefix, this.code});

  @override
  String toString() {
    return prefix != null ? '$prefix: $message' : message;
  }
}

/// Network-related exceptions (connection timeouts, offline status).
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code})
      : super(prefix: 'Network Error');
}

/// Server-side API exceptions (500, 502, 503).
class ServerException extends AppException {
  const ServerException(super.message, {super.code})
      : super(prefix: 'Server Error');
}

/// Authentication and authorization exceptions (401, 403).
class AuthException extends AppException {
  const AuthException(super.message, {super.code})
      : super(prefix: 'Authentication Error');
}

/// Form and input validation exceptions.
class ValidationException extends AppException {
  const ValidationException(super.message)
      : super(prefix: 'Validation Error');
}

/// Data parsing / serialization exceptions.
class ParseException extends AppException {
  const ParseException(super.message)
      : super(prefix: 'Parse Error');
}
