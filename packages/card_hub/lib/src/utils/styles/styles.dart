import 'package:flutter/material.dart';

import '../constants.dart';
part 'sizes.dart';
part 'text_styles.dart';

/// Single source of truth for styling.
///
/// TL;DR: Don't try and create every variant in existence here, just the high level ones (core & duplicates).
///
/// Like most rules, there are exceptions: one-off values that are used nowhere else in the app.
/// There is little point in cluttering up the styling rules with these values, but it’s worth
/// considering if they should be derived from an existing value (for example, padding + 1.0).
/// You should also watch for reuse or duplication of the same semantic values.
/// Those values should likely be added to this global styling ruleset.

/// A class containing static font styles for the application.
abstract class FontStyles {
  /// The font family 'halter'.
  static const String familyHalter = 'halter';

  /// The semi-bold font weight.
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
}
