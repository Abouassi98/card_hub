import 'local_exception_type.dart';

/// A base class for all possible exceptions that can occur in the application.
///
/// This class provides a standard way to handle exceptions throughout the app.
abstract class AppException implements Exception {
  
  /// Creates a base AppException
  const AppException({required this.message, this.code});

  /// The error message describing what went wrong
  final String message;
  
  /// Optional error code
  final int? code;
}

/// Represents a local exception that occurs within the application.
///
/// This is used for errors that are not related to network or server issues,
/// such as validation errors, permission errors, or other internal logic errors.
class LocalException extends AppException {
  
  /// Creates a LocalException
  const LocalException({
    required this.type,
    required super.message,
    super.code,
  });
  /// The specific type of local exception
  final LocalExceptionType type;
  
  @override
  String toString() => 'LocalException: $message (Type: $type, Code: $code)';
}
