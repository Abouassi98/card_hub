import 'package:flutter/material.dart';

import 'app_exception.dart';

/// Extension on [Object] to provide a user-friendly error message.
extension AppErrorExtension on Object? {
  /// Returns a localized error message based on the type of the exception.
  ///
  /// This method checks if the object is an [AppException] and returns a
  /// specific error message. Otherwise, it returns a generic 'Unknown error' message.
  String errorMessage(BuildContext context) {
    final error = this;
    if (error is AppException) {
      return error.map(
        localException: (ex) => ex.localErrorMessage(context),
      );
    }
    return 'Unknown error';
  }
}

/// Extension on [LocalException] to provide a user-friendly error message.
extension _LocalErrorExtension on LocalException {
  /// Returns a localized error message for a [LocalException].
  String localErrorMessage(BuildContext context) {
    return switch (type) {
      LocalExceptionType.general || LocalExceptionType.unsupported => message,
      _ => 'Unknown error',
    };
  }
}
