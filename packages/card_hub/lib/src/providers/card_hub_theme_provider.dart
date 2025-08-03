import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/card_hub_model.dart';
import '../utils/color_extractor.dart';
import '../utils/material_color_extractor.dart';

/// A provider class that generates Material 3 ThemeData from CardHubModel
///
/// This class can be used to apply dynamic theming to your entire app
/// based on the selected card in CardHub.
class CardHubThemeProvider extends ChangeNotifier {
  /// Creates a CardHubThemeProvider
  CardHubThemeProvider({
    this.useMaterial3 = true,
    this.defaultTheme,
  });

  /// Whether to use Material 3 features in the generated ThemeData
  final bool useMaterial3;
  
  /// Default theme to use when no card is selected
  final ThemeData? defaultTheme;
  
  /// Cache for storing generated themes
  final Map<String, ThemeData> _lightThemeCache = {};
  final Map<String, ThemeData> _darkThemeCache = {};
  
  /// Currently active theme data for light mode
  ThemeData? _lightTheme;
  
  /// Currently active theme data for dark mode
  ThemeData? _darkTheme;
  
  /// Currently selected card
  CardHubModel? _selectedCard;
  
  /// Get the current light theme
  ThemeData get lightTheme => _lightTheme ?? defaultTheme ?? ThemeData.light(useMaterial3: useMaterial3);
  
  /// Get the current dark theme
  ThemeData get darkTheme => _darkTheme ?? defaultTheme ?? ThemeData.dark(useMaterial3: useMaterial3);
  
  /// Get the currently selected card
  CardHubModel? get selectedCard => _selectedCard;
  
  /// Update the theme based on a selected card
  Future<void> updateThemeFromCard(CardHubModel? card) async {
    _selectedCard = card;
    
    if (card == null || card.logoAssetPath == null) {
      _lightTheme = defaultTheme ?? ThemeData.light(useMaterial3: useMaterial3);
      _darkTheme = defaultTheme ?? ThemeData.dark(useMaterial3: useMaterial3);
      notifyListeners();
      return;
    }
    
    // Check if we have cached themes for this card
    final String cacheKey = card.logoAssetPath!;
    
    if (_lightThemeCache.containsKey(cacheKey) && _darkThemeCache.containsKey(cacheKey)) {
      _lightTheme = _lightThemeCache[cacheKey];
      _darkTheme = _darkThemeCache[cacheKey];
      notifyListeners();
      return;
    }
    
    // Generate new themes
    try {
      final ByteData byteData = await rootBundle.load(card.logoAssetPath!);
      
      // Extract color schemes using Material 3 color extraction
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;
      
      try {
        // Try to use the new Material 3 color extraction
        final cacheKey = card.logoAssetPath!;
        lightColorScheme = await MaterialColorExtractor.extractCachedColorScheme(
          byteData, 
          cacheKey,
        );
        
        darkColorScheme = await MaterialColorExtractor.extractCachedColorScheme(
          byteData, 
          cacheKey,
          isDark: true,
        );
      } catch (e) {
        debugPrint('Material 3 extraction failed, falling back to legacy: $e');
        
        // Fallback to legacy extraction
        List<Color> lightPalette;
        List<Color> darkPalette;
        
        try {
          lightPalette = await ColorExtractor.extractCleanPalette(byteData);
          // Make a copy for dark palette
          darkPalette = await ColorExtractor.extractCleanPalette(byteData);
        } catch (e) {
          debugPrint('Could not extract colors from ${card.logoAssetPath}: $e');
          // Fallback colors
          lightPalette = [Colors.blue, Colors.lightBlue, Colors.blueAccent];
          darkPalette = [Colors.indigo, Colors.indigoAccent, Colors.blue];
        }
        
        // Ensure we have at least 3 colors in each palette
        while (lightPalette.length < 3) {
          lightPalette.add(lightPalette.isNotEmpty ? lightPalette.last : Colors.blue);
        }
        
        while (darkPalette.length < 3) {
          darkPalette.add(darkPalette.isNotEmpty ? darkPalette.last : Colors.indigo);
        }
        
        // Create color schemes from the palettes
        lightColorScheme = ColorScheme.fromSwatch().copyWith(
          primary: lightPalette[0],
          secondary: lightPalette[1],
          tertiary: lightPalette[2],
        );
        
        darkColorScheme = ColorScheme.fromSwatch(
          brightness: Brightness.dark,
        ).copyWith(
          primary: darkPalette[0],
          secondary: darkPalette[1],
          tertiary: darkPalette[2],
        );
      }
      
      // Create theme data using the color schemes
      _lightTheme = ThemeData(
        useMaterial3: useMaterial3,
        colorScheme: lightColorScheme,
      );
      
      _darkTheme = ThemeData(
        useMaterial3: useMaterial3,
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
      );
      
      // Cache the themes
      _lightThemeCache[cacheKey] = _lightTheme!;
      _darkThemeCache[cacheKey] = _darkTheme!;
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error generating theme from card: $e');
      _lightTheme = defaultTheme ?? ThemeData.light(useMaterial3: useMaterial3);
      _darkTheme = defaultTheme ?? ThemeData.dark(useMaterial3: useMaterial3);
      notifyListeners();
    }
  }
  
  /// Apply the current theme to a widget
  Widget applyTheme(Widget child, {bool useDarkTheme = false}) {
    return Theme(
      data: useDarkTheme ? darkTheme : lightTheme,
      child: child,
    );
  }
}
