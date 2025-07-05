import 'package:flutter/material.dart';

/// A class containing static colors for different parts of the application.
abstract class AppStaticColors {
  /// The linear gradient for MasterCard ingredient color.
  static const LinearGradient masterCardIngredientColor = LinearGradient(
    begin: Alignment(0.57, -0.82),
    end: Alignment(-0.57, 0.82),
    colors: [Color(0xFF7068A2), Color(0xFF3B3566)],
  );

  /// The linear gradient for VisaCard ingredient color.
  static const LinearGradient visaCardIngredientColor = LinearGradient(
    begin: Alignment(0.57, -0.82),
    end: Alignment(-0.57, 0.82),
    colors: [Color(0xff3c3c3c), Color(0xff1e1e1e)],
  );
}
