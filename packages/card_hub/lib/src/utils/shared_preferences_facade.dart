import 'package:shared_preferences/shared_preferences.dart';
import 'error/error_handlers.dart';

/// An enumeration of supported data types for [SharedPreferencesFacade].
enum DataType {
  /// Represents a [String] value.
  string,

  /// Represents an [int] value.
  int,

  /// Represents a [double] value.
  double,

  /// Represents a [bool] value.
  bool,

  /// Represents a [List<String>] value.
  stringList,
}

/// A facade for the `shared_preferences` package, providing a simplified and
/// type-safe interface for storing and retrieving data.
///
/// This class is a singleton and must be initialized with [init] before use.
class SharedPreferencesFacade {
  SharedPreferencesFacade._(this._sharedPrefs);

  /// The key used to store the default card ID in shared preferences.
  static String defaultCardIdKey = 'defaultCardId';
  static SharedPreferencesFacade? _instance;
  final SharedPreferences _sharedPrefs;

  /// Lazily gets or creates the singleton instance.
  static Future<SharedPreferencesFacade> get instance async {
    _instance ??= SharedPreferencesFacade._(
      await SharedPreferences.getInstance(),
    );
    return _instance!;
  }

  /// Saves a value to shared preferences with the specified [key].
  ///
  /// The [value] must be one of the supported types: [String], [int], [double],
  /// [bool], or [List<String>].
  ///
  /// Returns `true` if the value was saved successfully, otherwise `false`.
  Future<bool> saveData({
    required String key,
    required Object value,
  }) async {
    return localErrorAsyncHandler(() async {
      return switch (value) {
        final String v => _sharedPrefs.setString(key, v),
        final int v => _sharedPrefs.setInt(key, v),
        final double v => _sharedPrefs.setDouble(key, v),
        final bool v => _sharedPrefs.setBool(key, v),
        final List<String> v => _sharedPrefs.setStringList(key, v),
        _ => throw UnsupportedError(
            'Only String, int, double, bool, or List<String> are supported.',
          ),
      };
    });
  }

  /// Restores a value of type [T] from shared preferences using the given [key].
  ///
  /// Returns the value if it exists, otherwise `null`.
  /// Throws an [UnsupportedError] if [T] is not a supported type.
  T? restoreData<T>(String key) {
    return localErrorSyncHandler(() {
      return switch (T) {
        String => _sharedPrefs.getString(key) as T?,
        int => _sharedPrefs.getInt(key) as T?,
        double => _sharedPrefs.getDouble(key) as T?,
        bool => _sharedPrefs.getBool(key) as T?,
        const (List<String>) => _sharedPrefs.getStringList(key) as T?,
        _ => throw UnsupportedError(
            'Only String, int, double, bool, or List<String> are supported.',
          ),
      };
    });
  }

  /// Clears all data from shared preferences.
  Future<bool> clearAll() => localErrorAsyncHandler(() => _sharedPrefs.clear());

  /// Removes a specific [key] and its associated value from shared preferences.
  Future<bool> clearKey(String key) => localErrorAsyncHandler(() => _sharedPrefs.remove(key));
}
