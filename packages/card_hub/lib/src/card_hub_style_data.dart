part of 'card_hub.dart';

/// A class that defines the visual style configuration for a credit card widget.
class CardHubStyleData {
  /// Creates a [CardHubStyleData] instance with the specified parameters.
  const CardHubStyleData({
    this.width,
    this.padding,
    this.margin,
    this.animationDuration,
    this.logoImage,
    this.isHolderNameVisible = false,
    this.labelValidThru,
    this.labelCardHolder,
    this.gradient,
    this.textStyle,
  });

  /// The width of the credit card widget.
  final double? width;

  /// The margin to apply outside the credit card widget in all directions.
  /// Defaults to [EdgeInsets.all(16.0)].
  final EdgeInsetsGeometry? margin;

  /// The padding to apply inside the credit card widget in all directions.
  /// Defaults to [EdgeInsets.all(16.0)].
  final EdgeInsetsGeometry? padding;

  /// The default label for the "valid thru" field. This label is displayed
  /// when the user has not entered any text for the "valid thru" field.
  final String? labelValidThru;

  /// The default label for the card holder's name. This label is displayed
  /// when the user has not entered any text for the card holder's name field.
  final String? labelCardHolder;

  /// The path to the logo image of the service provider (e.g., Visa, MasterCard).
  /// This image should be available locally in the assets folder.
  final String? logoImage;

  /// Determines whether the card holder's name field is visible or not.
  /// Defaults to `false`.
  final bool isHolderNameVisible;

  /// The duration for the flip animation. Defaults to [Duration(milliseconds: 245)].
  final Duration? animationDuration;

  /// The text style to apply to the card number, expiry date, and card holder's name.
  final TextStyle? textStyle;

  /// The gradient to apply as the background of the credit card widget.
  final Gradient? gradient;
}
