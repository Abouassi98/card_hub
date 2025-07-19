import 'package:flutter/material.dart';
import '../../utils/styles/styles.dart';

/// A widget representing the details of a credit card.
class CardHubDetails extends StatelessWidget {
  /// Constructs a [CardHubDetails].
  const CardHubDetails({
    super.key,
    required this.label,
    required this.value,
    this.textStyle,
    this.overrideColor, // 👈 Add new property
  });

  /// The label for the card detail.
  final String label;

  /// The value of the card detail.
  final String value;

  /// The base style for the card detail text.
  final TextStyle? textStyle;

  /// An optional color to override the default text styles.
  final Color? overrideColor; // 👈 Define property

  @override
  Widget build(BuildContext context) {
    // 👈 Build the final text styles, applying the override color last
    final baseStyle = textStyle ?? TextStyles.defaultCreditCardStyle(context);
    final finalStyle = baseStyle.copyWith(color: overrideColor ?? baseStyle.color);
    final finalLabelStyle = TextStyles.defaultCreditCardStyle(context)
        .copyWith(fontSize: 7, color: overrideColor ?? baseStyle.color);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: finalLabelStyle, // 👈 Use final style
        ),
        const SizedBox(height: Sizes.marginV4),
        Text(
          value,
          style: finalStyle, // 👈 Use final style
        ),
      ],
    );
  }
}
