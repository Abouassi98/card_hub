import 'package:flutter/material.dart';

import '../../card_hub.dart';
import 'app_static_colors.dart';

/// Enum representing different types of credit cards.
enum CardType {
  otherBrand,

  /// Visa credit card.
  visa,

  /// Mastercard credit card.
  mastercard,

  rupay,
  americanExpress,
  unionpay,
  discover,
  elo;

  /// Returns the image asset path for the card type.
  String get image => switch (this) {
        visa => AssetPaths.ASSETS_IMAGES_CARDS_VISA_SVG,
        mastercard => AssetPaths.ASSETS_IMAGES_CARDS_MASTERCARD_SVG,
        (_) => ''
      };

  /// Returns the gradient for the card type.
  Gradient get gradient => switch (this) {
        visa => AppStaticColors.visaCardIngredientColor,
        mastercard => AppStaticColors.masterCardIngredientColor,
        (_) => AppStaticColors.masterCardIngredientColor
      };
}
