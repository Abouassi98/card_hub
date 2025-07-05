import 'package:flutter/material.dart';

import '../../utils/styles/styles.dart';

/// A widget representing the details of a credit card.
class CardHubDetails extends StatelessWidget {
  /// Constructs a [CardHubDetails].
  const CardHubDetails({super.key, required this.label, required this.value, this.textStyle});

  /// The label for the card detail.
  final String label;

  /// The value of the card detail.
  final String value;

  /// The style for the card detail.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyles.defaultCreditCardStyle(context).copyWith(fontSize: 7)),
        const SizedBox(height: Sizes.marginV4),
        Text(value, style: textStyle ?? TextStyles.defaultCreditCardStyle(context)),
      ],
    );
  }
}
