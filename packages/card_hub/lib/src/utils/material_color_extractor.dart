import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'color_extractor.dart';

/// A utility class for extracting Material 3 color schemes from images
/// using legacy-inspired filtering and quantization techniques.
class MaterialColorExtractor {
  /// Private constructor to prevent instantiation
  MaterialColorExtractor._();

  /// Cache for storing extracted color schemes to avoid repeated processing
  static final Map<String, ColorScheme> _colorSchemeCache = {};

  /// Extracts a Material 3 color scheme from an image
  ///
  /// [byteData] - The raw image data
  /// [isDark] - Whether to generate a dark or light theme
  /// [cacheKey] - Optional key for caching results
  /// Returns a Flutter ColorScheme
  static Future<ColorScheme> extractColorScheme(
    ByteData byteData, {
    bool isDark = false,
    String? cacheKey,
  }) async {
    // Use cache if available
    if (cacheKey != null && _colorSchemeCache.containsKey(cacheKey)) {
      return _colorSchemeCache[cacheKey]!;
    }

    try {
      // Extract colors using the legacy color extractor
      final List<Color> palette = await ColorExtractor.extractCleanPalette(byteData);

      // Create a color scheme from the palette
      final colorScheme = _createColorScheme(palette, isDark);

      // Cache the result if a cache key was provided
      if (cacheKey != null) {
        _colorSchemeCache[cacheKey] = colorScheme;
      }

      return colorScheme;
    } catch (e) {
      debugPrint('Error extracting color scheme: $e');
      return _fallbackColorScheme(isDark);
    }
  }

  /// Extracts a Material 3 color scheme from an image with caching
  ///
  /// [byteData] - The raw image data
  /// [assetPath] - The asset path for caching
  /// [isDark] - Whether to generate a dark or light theme
  /// Returns a Flutter ColorScheme
  static Future<ColorScheme> extractCachedColorScheme(
    ByteData byteData,
    String assetPath, {
    bool isDark = false,
  }) async {
    // Generate cache key
    final cacheKey = '$assetPath-${isDark ? 'dark' : 'light'}';

    // Extract the scheme with caching
    return extractColorScheme(byteData, isDark: isDark, cacheKey: cacheKey);
  }

  /// Creates a color scheme from a palette
  ///
  /// [palette] - The list of colors
  /// [isDark] - Whether to generate a dark or light theme
  /// Returns a Flutter ColorScheme
  static ColorScheme _createColorScheme(List<Color> palette, bool isDark) {
    // Ensure we have at least 3 colors in the palette
    final List<Color> extendedPalette = List.from(palette);

    // Add more colors if needed by deriving from existing ones
    while (extendedPalette.length < 3) {
      if (extendedPalette.isEmpty) {
        extendedPalette.add(Colors.blue);
      } else {
        // Create a slightly different shade of the last color
        final lastColor = extendedPalette.last;
        final hsl = HSLColor.fromColor(lastColor);
        final newHsl = hsl.withLightness((hsl.lightness - 0.1).clamp(0.1, 0.9));
        extendedPalette.add(newHsl.toColor());
      }
    }

    // Get the primary colors
    final primary = extendedPalette[0];
    final secondary = extendedPalette[1];
    final tertiary = extendedPalette[2];

    // Calculate contrasting colors
    final onPrimary = _contrastingColor(primary);
    final onSecondary = _contrastingColor(secondary);
    final onTertiary = _contrastingColor(tertiary);

    // Create container colors (lighter/darker variants)
    final primaryHsl = HSLColor.fromColor(primary);
    final secondaryHsl = HSLColor.fromColor(secondary);
    final tertiaryHsl = HSLColor.fromColor(tertiary);

    final primaryContainer = isDark
        ? primaryHsl.withLightness((primaryHsl.lightness * 0.5).clamp(0.05, 0.3)).toColor()
        : primaryHsl.withLightness((primaryHsl.lightness * 1.2).clamp(0.7, 0.95)).toColor();

    final secondaryContainer = isDark
        ? secondaryHsl.withLightness((secondaryHsl.lightness * 0.5).clamp(0.05, 0.3)).toColor()
        : secondaryHsl.withLightness((secondaryHsl.lightness * 1.2).clamp(0.7, 0.95)).toColor();

    final tertiaryContainer = isDark
        ? tertiaryHsl.withLightness((tertiaryHsl.lightness * 0.5).clamp(0.05, 0.3)).toColor()
        : tertiaryHsl.withLightness((tertiaryHsl.lightness * 1.2).clamp(0.7, 0.95)).toColor();

    final onPrimaryContainer = _contrastingColor(primaryContainer);
    final onSecondaryContainer = _contrastingColor(secondaryContainer);
    final onTertiaryContainer = _contrastingColor(tertiaryContainer);

    // Create error colors
    final error = Colors.red.shade700;
    const onError = Colors.white;
    final errorContainer = isDark ? Colors.red.shade900 : Colors.red.shade200;
    final onErrorContainer = isDark ? Colors.red.shade200 : Colors.red.shade900;

    // Create surface colors
    final surface = isDark ? Colors.grey.shade900 : Colors.grey.shade50;
    final onSurface = isDark ? Colors.white : Colors.black;
    final surfaceVariant = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final onSurfaceVariant = isDark ? Colors.grey.shade300 : Colors.grey.shade700;

    // Create outline colors
    final outline = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final outlineVariant = isDark ? Colors.grey.shade600 : Colors.grey.shade400;

    // Create inverse colors
    final inverseSurface = isDark ? Colors.grey.shade50 : Colors.grey.shade900;
    final onInverseSurface = isDark ? Colors.black : Colors.white;
    final inversePrimary = isDark ? primary.withAlpha(128) : primary.withAlpha(192);

    return ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
    );
  }

  /// Returns a fallback color scheme if extraction fails
  static ColorScheme _fallbackColorScheme(bool isDark) {
    return ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
  }

  /// Calculate a contrasting color (black or white) based on the brightness of the input color
  static Color _contrastingColor(Color color) {
    // Use Flutter's built-in relative luminance computation.
    // Range: 0.0 (darkest) to 1.0 (lightest).
    final luminance = color.computeLuminance();

    // Return white text for dark colors, black text for light colors.
    // Threshold 0.5 is a practical heuristic for contrast.
    return luminance < 0.5 ? Colors.white : Colors.black;
  }
}
