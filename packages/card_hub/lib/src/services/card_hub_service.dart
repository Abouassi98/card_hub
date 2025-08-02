import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/card_hub_model.dart';
import '../utils/color_extractor.dart';
import '../utils/shared_preferences_facade.dart';

/// A service class that handles all business logic for CardHub
/// This approach separates business logic from UI without using state management
class CardHubService {

  /// Private constructor to prevent instantiation
  CardHubService._();
  /// The key for storing the default card ID in SharedPreferences
  static const String defaultCardIdKey = 'default_card_id';

  /// Gets the default card ID from local storage
  static Future<String?> getDefaultCardId() async {
    return (await SharedPreferencesFacade.instance)
        .restoreData<String>(defaultCardIdKey);
  }

  /// Saves the default card ID to local storage
  static Future<void> saveDefaultCardId(String cardId) async {
    await (await SharedPreferencesFacade.instance).saveData(
      key: defaultCardIdKey,
      value: cardId,
    );
  }

  /// Reorders the list based on the default card ID
  static List<CardHubModel> reorderCardsByDefaultId(
      List<CardHubModel> items, String? defaultCardId) {
    if (defaultCardId == null) {
      return List.from(items);
    }

    final List<CardHubModel> sortedList = List.from(items);
    final int defaultIndex =
        sortedList.indexWhere((item) => item.id == defaultCardId);
    
    if (defaultIndex != -1) {
      final defaultItem = sortedList.removeAt(defaultIndex);
      sortedList.insert(0, defaultItem);
    }
    
    return sortedList;
  }

  /// Extracts color palettes from logo assets
  static Future<Map<String, List<Color>>> extractColorPalettes(
      List<CardHubModel> items) async {
    final uniqueLogoPaths = items.map((item) => item.logoAssetPath).toSet();
    final Map<String, List<Color>> palettes = {};

    // Process each unique logo path
    for (final path in uniqueLogoPaths) {
      if (path == null) {
        continue;
      }
      
      try {
        final byteData = await rootBundle.load(path);
        final palette = await compute(decodeAndExtractCleanPalette, byteData);
        palettes[path] = palette;
      } catch (e) {
        debugPrint('Could not process logo $path: $e');
      }
    }

    return palettes;
  }

  /// Finds the index of the default card in the items list
  static int? findDefaultCardIndex(List<CardHubModel> items, String? defaultCardId) {
    if (defaultCardId == null) {
      return null;
    }
    return items.indexWhere((item) => item.id == defaultCardId);
  }
}
