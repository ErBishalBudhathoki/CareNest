import 'package:flutter/foundation.dart';

/// Secure error handler that prevents sensitive information disclosure
class SecureErrorHandler {
  // Generic error messages that don't expose internal details
  static const String _genericAuthError = 'Authentication failed. Please check your credentials and try again.';
  static const String _genericNetworkError = 'Network error. Please check your connection and try again.';
  static const String _genericServerError = 'Service temporarily unavailable. Please try again later.';
  static const String _genericValidationError = 'Please check your input and try again.';
  
  /// Sanitizes error messages to prevent sensitive information disclosure
  static String sanitizeErrorMessage(dynamic error, {String? fallbackMessage}) {
    if (error == null) {
      return fallbackMessage ?? 'An unexpected error occurred.';
    }
    
    String errorMessage = error.toString().toLowerCase();
    
    // Check for sensitive information patterns and replace with generic messages
    if (_containsSensitiveInfo(errorMessage)) {
      return _getGenericErrorMessage(errorMessage);
    }
    
    // For known safe error messages, return them as-is
    if (_isSafeErrorMessage(errorMessage)) {
      return error.toString();
    }
    
    // Default to generic message for unknown errors
    return fallbackMessage ?? 'An unexpected error occurred.';
  }
  
  /// Checks if error message contains sensitive information
  static bool _containsSensitiveInfo(String errorMessage) {
    final sensitivePatterns = [
      // Database/MongoDB patterns
      r'mongodb',
      r'collection',
      r'database',
      r'connection',
      r'timeout',
      r'socket',
      
      // Server/API patterns
      r'http://.*',
      r'https://.*',
      r'localhost',
      r'127\.0\.0\.1',
      r'192\.168\.',
      r'10\.0\.',
      r'172\.',
      r'port \d+',
      r'server error',
      r'internal error',
      r'stack trace',
      r'exception',
      
      // Authentication/Security patterns
      r'token',
      r'jwt',
      r'bearer',
      r'authorization',
      r'secret',
      r'key',
      r'salt',
      r'hash',
      r'password.*format',
      r'invalid.*format',
      
      // File system patterns
      r'/.*/',
      r'c:\\.*',
      r'file not found',
      r'permission denied',
      
      // Development/Debug patterns
      r'debug',
      r'console',
      r'log',
      r'trace',
    ];
    
    for (String pattern in sensitivePatterns) {
      if (RegExp(pattern, caseSensitive: false).hasMatch(errorMessage)) {
        return true;
      }
    }
    
    return false;
  }
  
  /// Returns appropriate generic error message based on error type
  static String _getGenericErrorMessage(String errorMessage) {
    if (errorMessage.contains('network') || 
        errorMessage.contains('connection') ||
        errorMessage.contains('timeout') ||
        errorMessage.contains('socket')) {
      return _genericNetworkError;
    }
    
    if (errorMessage.contains('auth') ||
        errorMessage.contains('login') ||
        errorMessage.contains('password') ||
        errorMessage.contains('credential') ||
        errorMessage.contains('unauthorized') ||
        errorMessage.contains('forbidden')) {
      return _genericAuthError;
    }
    
    if (errorMessage.contains('server') ||
        errorMessage.contains('internal') ||
        errorMessage.contains('500') ||
        errorMessage.contains('503')) {
      return _genericServerError;
    }
    
    if (errorMessage.contains('validation') ||
        errorMessage.contains('invalid') ||
        errorMessage.contains('format') ||
        errorMessage.contains('required')) {
      return _genericValidationError;
    }
    
    return 'An unexpected error occurred. Please try again.';
  }
  
  /// Checks if error message is safe to display to users
  static bool _isSafeErrorMessage(String errorMessage) {
    final safeMessages = [
      'user not found',
      'invalid email or password',
      'email already exists',
      'passwords do not match',
      'invalid organization code',
      'organization not found',
      'form is not valid',
      'network error',
      'please check your connection',
      'service temporarily unavailable',
      'authentication failed',
      'login failed',
      'signup failed',
      'invalid credentials',
      'account not found',
      'email is required',
      'password is required',
      'invalid email format',
      'password too short',
      'password too weak',
    ];
    
    return safeMessages.any((safe) => errorMessage.contains(safe));
  }
  
  /// Logs error details securely for debugging (only in debug mode)
  static void logError(String context, dynamic error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('=== SECURE ERROR LOG ===');
      debugPrint('Context: $context');
      debugPrint('Error: $error');
      if (stackTrace != null) {
        debugPrint('Stack Trace: $stackTrace');
      }
      debugPrint('========================');
    }
  }
  
  /// Creates a user-friendly error response for authentication
  static Map<String, dynamic> createAuthErrorResponse(dynamic error) {
    final sanitizedMessage = sanitizeErrorMessage(error, 
        fallbackMessage: _genericAuthError);
    
    return {
      'success': false,
      'message': sanitizedMessage,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
  
  /// Creates a user-friendly error response for network issues
  static Map<String, dynamic> createNetworkErrorResponse(dynamic error) {
    final sanitizedMessage = sanitizeErrorMessage(error, 
        fallbackMessage: _genericNetworkError);
    
    return {
      'success': false,
      'message': sanitizedMessage,
      'timestamp': DateTime.now().toIso8601String(),
      'retry': true,
    };
  }
  
  /// Validates and sanitizes user input
  static String sanitizeInput(String input) {
    if (input.isEmpty) return input;
    
    // Remove potentially dangerous characters
    String sanitized = input
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('"', '')
        .replaceAll("'", '')
        .replaceAll('/', '')
        .replaceAll('\\', '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    
    return sanitized;
  }
  
  /// Validates email format without exposing validation logic
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    
    return emailRegex.hasMatch(email);
  }
  
  /// Validates password strength without exposing criteria
  static bool isValidPassword(String password) {
    if (password.isEmpty) return false;
    
    // Basic validation - at least 6 characters
    // More complex rules can be added here
    return password.length >= 6;
  }
}