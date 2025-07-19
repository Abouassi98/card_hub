import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

/// A utility class to extract the dominant color from an image asset.
class ColorExtractor {
  /// Extracts the dominant color from the image at the given [assetPath].
  static Future<Color> extractColor(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final image = img.decodeImage(byteData.buffer.asUint8List());

    if (image == null) {
      throw Exception('Could not decode image from asset: $assetPath');
    }

    final resizedImage = img.copyResize(image, width: 64);
    final colorCounts = <int, int>{};
    int maxCount = 0;
    int dominantColor = Colors.blue.value; // Fallback default color

    for (final pixel in resizedImage) {
      final r = pixel.r.toInt();
      final g = pixel.g.toInt();
      final b = pixel.b.toInt();

      // 👇 --- New Logic: Ignore Black and White ---
      // This threshold helps ignore pure black or white backgrounds.
      // If a color is very dark (all channels below 10) or very light
      // (all channels above 245), we skip it.
      if ((r < 10 && g < 10 && b < 10) || (r > 245 && g > 245 && b > 245)) {
        continue; // Skip this pixel
      }
      // --- End of New Logic ---

      // We still quantize to group similar colors
      final quantizedR = (r ~/ 16) * 16;
      final quantizedG = (g ~/ 16) * 16;
      final quantizedB = (b ~/ 16) * 16;
      final quantizedColor = (0xFF << 24) | (quantizedR << 16) | (quantizedG << 8) | quantizedB;

      final count = (colorCounts[quantizedColor] ?? 0) + 1;
      colorCounts[quantizedColor] = count;

      if (count > maxCount) {
        maxCount = count;
        dominantColor = quantizedColor;
      }
    }

    // If the image was ONLY black and white, we might not have a dominant color.
    // In that case, we can find the average color as a fallback.
    if (colorCounts.isEmpty) {
      num totalR = 0, totalG = 0, totalB = 0;
      for (final pixel in resizedImage) {
        totalR += pixel.r;
        totalG += pixel.g;
        totalB += pixel.b;
      }
      final avgR = totalR ~/ resizedImage.length;
      final avgG = totalG ~/ resizedImage.length;
      final avgB = totalB ~/ resizedImage.length;
      return Color.fromARGB(255, avgR, avgG, avgB);
    }

    return Color(dominantColor);
  }
}
