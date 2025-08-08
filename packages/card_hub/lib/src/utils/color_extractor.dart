import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

/// Isolate entry point for the new, simplified color extraction logic.
Future<List<Color>> decodeAndExtractCleanPalette(ByteData imageBytes) async {
  return ColorExtractor.extractCleanPalette(imageBytes);
}

/// A utility class to extract a clean, aesthetically-pleasing color palette from an image.
class ColorExtractor {
  /// Extracts the most dominant colors from an image to create a gradient palette.
  static Future<List<Color>> extractCleanPalette(ByteData byteData) async {
    // A fallback color in case of any processing failure.
    final fallbackPalette = [Colors.blueGrey.shade700, Colors.blueGrey.shade900];

    try {
      final image = img.decodeImage(byteData.buffer.asUint8List());

      if (image == null) {
        return fallbackPalette;
      }

      final resizedImage = img.copyResize(image, width: 64);
      final colorCounts = <int, int>{};

      for (final pixel in resizedImage) {
        // --- 1. Primary Filtering ---
        if (pixel.a < 250) {
          continue;
        }

        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();

        // --- 2. RGB-based Neutral Color Filtering ---
        if ((r < 35 && g < 35 && b < 35) || (r > 220 && g > 220 && b > 220)) {
          continue;
        }

        // --- 3. Quantize and Count the Remaining Colors ---
        const step = 20;
        final quantizedColor = (0xFF << 24) |
            (((r ~/ step) * step) << 16) |
            (((g ~/ step) * step) << 8) |
            ((b ~/ step) * step);

        colorCounts[quantizedColor] = (colorCounts[quantizedColor] ?? 0) + 1;
      }

      if (colorCounts.isEmpty) {
        return fallbackPalette;
      }

      // --- 4. Find the Most Dominant Colors ---
      final sortedColors = colorCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

      // --- KEY CHANGE ---
      // If we have two or more distinct, dominant colors, use them.
      if (sortedColors.length >= 2) {
        final primaryColor = Color(sortedColors[0].key);
        final secondaryColor = Color(sortedColors[1].key);
        return [primaryColor, secondaryColor];
      }

      // If we only found one dominant color, create a gradient from it.
      if (sortedColors.isNotEmpty) {
        final primaryColor = Color(sortedColors.first.key);
        final hsl = HSLColor.fromColor(primaryColor);
        final darkerHsl = hsl.withLightness((hsl.lightness * 0.7).clamp(0.0, 1.0));
        return [primaryColor, darkerHsl.toColor()];
      }

      return fallbackPalette;
    } catch (e) {
      debugPrint('Error extracting palette: $e');
      return fallbackPalette;
    }
  }
}
