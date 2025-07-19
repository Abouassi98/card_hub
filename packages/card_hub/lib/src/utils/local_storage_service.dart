// lib/services/local_storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _defaultCardKey = 'defaultCardId';

  /// Saves the unique ID of the default card.
  static Future<void> saveDefaultCardId(String cardId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_defaultCardKey, cardId);
  }

  /// Retrieves the unique ID of the saved default card.
  /// Returns null if no default card has been set.
  static Future<String?> getDefaultCardId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_defaultCardKey);
  }
}