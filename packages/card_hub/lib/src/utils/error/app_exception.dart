import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

part 'local_exception_type.dart';

/// A union of all possible exceptions that can occur in the application.
///
/// This class uses the `freezed` package to generate a sealed class hierarchy,
/// ensuring that all exception types are handled explicitly.
@freezed
class AppException with _$AppException implements Exception {

  /// Represents a local exception that occurs within the application.
  ///
  /// This is used for errors that are not related to network or server issues,
  /// such as validation errors, permission errors, or other internal logic errors.
  const factory AppException.localException({
    required LocalExceptionType type,
    required String message,
    int? code,
  }) = LocalException;
}
