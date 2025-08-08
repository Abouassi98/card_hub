import 'package:flutter/material.dart';

import 'app_static_colors.dart';
import 'asset_paths.dart';

/// Enum representing different types of credit cards.
enum CardType {
  /// Represents a credit card of an unspecified or unsupported brand.
  otherBrand,

  /// Visa credit card.
  visa,

  /// Mastercard credit card.
  mastercard,

  /// RuPay credit card.
  rupay,

  /// American Express credit card.
  americanExpress,

  /// UnionPay credit card.
  unionpay,

  /// Discover credit card.
  discover,

  /// Elo credit card.
  elo;

  /// Returns the image asset path for the card type.
  String get image => switch (this) {
        visa => AssetPaths.ASSETS_IMAGES_CARDS_VISA_SVG,
        mastercard => AssetPaths.ASSETS_IMAGES_CARDS_MASTERCARD_SVG,
        (_) => '',
      };

  /// Returns the gradient for the card type.
  Gradient get gradient => switch (this) {
        visa => AppStaticColors.visaCardIngredientColor,
        mastercard => AppStaticColors.masterCardIngredientColor,
        (_) => AppStaticColors.masterCardIngredientColor,
      };
}
