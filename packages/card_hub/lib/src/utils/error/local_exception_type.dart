// Defines the types of local exceptions that can occur in the application.

/// Defines the specific type of a [LocalException].
enum LocalExceptionType {
  /// An unknown or unexpected error occurred.
  unknown,

  /// A general-purpose error for cases that don't fit other types.
  general,

  /// The operation was cancelled by the user or the system.
  cancelled,

  /// The requested operation or feature is not supported.
  unsupported,

  /// The requested resource was not found.
  ///
  /// Thrown when a key is not found, or cache is empty.
  notFound,

  /// The resource has expired.
  ///
  /// Thrown when cache is expired.
  expired;
}
