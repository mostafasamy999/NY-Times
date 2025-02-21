

import 'exceptions.dart';

class ErrorHandler {
  static String getMessage(dynamic error) {
    if (error is NetworkException) {
      return 'Unable to connect to the server. Please check your internet connection.';
    } else if (error is NetworkTimeoutException) {
      return 'Connection timed out. Please try again.';
    } else if (error is UnauthorizedException) {
      return 'Authentication failed. Please check your API key.';
    } else if (error is ForbiddenException) {
      return 'You do not have permission to access this resource.';
    } else if (error is NotFoundException) {
      return 'The requested content could not be found.';
    } else if (error is RateLimitedException) {
      return 'Too many requests. Please try again later.';
    } else if (error is ServerException) {
      return 'Server error occurred. Please try again later.';
    } else if (error is ApiException) {
      return 'API error: ${error.message}';
    } else {
      return 'An unexpected error occurred: ${error.toString()}';
    }
  }

  static String getActionText(dynamic error) {
    if (error is NetworkException || error is NetworkTimeoutException) {
      return 'Check Connection';
    } else if (error is RateLimitedException) {
      return 'Try Later';
    } else {
      return 'Try Again';
    }
  }
}