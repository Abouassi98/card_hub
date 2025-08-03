import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/card_hub_model.dart';
import '../utils/color_extractor.dart';
import '../utils/material_color_extractor.dart';
import '../utils/shared_preferences_facade.dart';

/// A service class that handles all business logic for CardHub
/// This approach separates business logic from UI without using state management
class CardHubService {
  /// Private constructor to prevent instantiation
  CardHubService._();
  
  /// Cache for storing extracted color palettes to avoid repeated processing
  static final Map<String, List<Color>> _colorPaletteCache = {};
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
      
      // Check if we already have this palette cached
      if (_colorPaletteCache.containsKey(path)) {
        palettes[path] = _colorPaletteCache[path]!;
        continue;
      }
      
      try {
        final byteData = await rootBundle.load(path);
        
        // Use the new Material 3 color extraction for premium branding
        try {
          // First try the new Material 3 color extraction
          final colorScheme = await MaterialColorExtractor.extractCachedColorScheme(
            byteData, 
            path,
          );
          
          // Create a palette from the color scheme's primary colors
          final palette = [
            colorScheme.primary,
            colorScheme.secondary,
            colorScheme.tertiary,
          ];
          
          palettes[path] = palette;
          
          // Cache the result for future use
          _colorPaletteCache[path] = palette;
        } catch (materialError) {
          debugPrint('Material 3 extraction failed, falling back to legacy: $materialError');
          
          // Fallback to legacy extraction if Material 3 fails
          final colorScheme = await ColorExtractor.extractCleanPalette(byteData);
          
          // Create a palette from the legacy extraction
          // Ensure we have at least 3 colors by duplicating the last one if needed
          final List<Color> extendedPalette = List.from(colorScheme);
          while (extendedPalette.length < 3) {
            if (extendedPalette.isEmpty) {
              extendedPalette.add(Colors.blue);
            } else {
              extendedPalette.add(extendedPalette.last);
            }
          }
          
          final palette = [
            extendedPalette[0],
            extendedPalette[1],
            extendedPalette[2],
          ];
          
          palettes[path] = palette;
          
          // Cache the result for future use
          _colorPaletteCache[path] = palette;
        }
      } catch (e) {
        debugPrint('Could not process logo $path: $e');
        // Fallback to legacy extraction method if Material 3 extraction fails
        try {
          final byteData = await rootBundle.load(path);
          final palette = await compute(decodeAndExtractCleanPalette, byteData);
          palettes[path] = palette;
          _colorPaletteCache[path] = palette;
        } catch (e) {
          debugPrint('Legacy extraction also failed for $path: $e');
        }
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
