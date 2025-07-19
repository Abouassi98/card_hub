import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

/// Isolate entry point for the new, simplified color extraction logic.
Future<List<Color>> decodeAndExtractCleanPalette(ByteData imageBytes) async {
  return ColorExtractor.extractCleanPalette(imageBytes);
}

/// A utility class to extract a clean, aesthetically-pleasing color palette from an image.
///
/// This version uses a simpler, more robust algorithm that filters by RGB and finds the
/// most dominant, non-neutral color.
class ColorExtractor {
  /// Extracts the most dominant, non-black/non-white color and creates a gradient palette.
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
        // Ignore any pixel that is not fully opaque.
        if (pixel.a < 250) continue;

        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();

        // --- 2. RGB-based Neutral Color Filtering ---
        // This is the KEY FIX: We explicitly ignore pixels that are very dark (like the
        // black background and arrows in `mozodi.png`) or very bright.
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

      // --- 4. Find the Most Dominant Color ---
      final sortedColors = colorCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final primaryColor = Color(sortedColors.first.key);

      // --- 5. Programmatically Create a Gradient ---
      // We create a second, darker color from the primary one for a nice effect.
      final hsl = HSLColor.fromColor(primaryColor);
      final darkerHsl = hsl.withLightness((hsl.lightness * 0.7).clamp(0.0, 1.0));

      return [primaryColor, darkerHsl.toColor()];

    } catch (e) {
      // If anything goes wrong during processing, return the fallback.
      return fallbackPalette;
    }
  }
}