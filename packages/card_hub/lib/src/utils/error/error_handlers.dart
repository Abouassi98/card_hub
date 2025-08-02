import 'app_exception.dart';
import 'local_exception_type.dart';

/// Extension on [Object] to convert errors to [AppException].
extension LocalErrorExtension on Object {
  AppException _localErrorToLocalException() {
    final error = this;

    return error is AppException
        ? error
        : LocalException(
            type: LocalExceptionType.unknown,
            message: error.toString(),
          );
  }
}

/// Handles synchronous errors by catching exceptions and converting them into a
/// standardized [AppException] format.
///
/// The [body] function is executed within a try-catch block. If an exception
/// is caught, it can be optionally transformed by the [errorMutator] before
/// being converted to an [AppException] and re-thrown with the original stack trace.
T localErrorSyncHandler<T>(T Function() body, {Object Function(Object e)? errorMutator}) {
  try {
    return body.call();
  } catch (e, st) {
    final mutatedError = errorMutator?.call(e) ?? e;
    final error = mutatedError._localErrorToLocalException();
    throw Error.throwWithStackTrace(error, st);
  }
}

/// Handles asynchronous errors by catching exceptions and converting them into a
/// standardized [AppException] format.
///
/// The [body] future is executed within a try-catch block. If an exception
/// is caught, it can be optionally transformed by the [errorMutator] before
/// being converted to an [AppException] and re-thrown with the original stack trace.
Future<T> localErrorAsyncHandler<T>(
  Future<T> Function() body, {
  Object Function(Object e)? errorMutator,
}) async {
  try {
    return await body.call();
  } catch (e, st) {
    final mutatedError = errorMutator?.call(e) ?? e;
    final error = mutatedError._localErrorToLocalException();
    throw Error.throwWithStackTrace(error, st);
  }
}
