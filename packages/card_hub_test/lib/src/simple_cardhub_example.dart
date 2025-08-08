import 'package:card_hub/card_hub.dart';
import 'package:flutter/material.dart';

/// A minimal example widget that demonstrates how to render a list of
/// `CardHubModel` items using the `CardHub` widget.
///
/// Place this inside a `MaterialApp` to preview the default Card Hub UI.
/// Intended for testing and example usage within `card_hub_test`.
class SimpleCardHubExample extends StatelessWidget {
  /// Creates a new `SimpleCardHubExample`.
  ///
  /// Optionally accepts a [key] for widget identification.
  const SimpleCardHubExample({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <CardHubModel>[
      const CardHubModel(
        id: '1',
        lastFour: 1234,
        expirationMonth: 12,
        expirationYear: 30,
        cardHolderName: 'John Doe',
        type: CardType.visa,
        bankName: 'Acme Bank',
        isDefault: true,
      ),
      const CardHubModel(
        id: '2',
        lastFour: 5678,
        expirationMonth: 11,
        expirationYear: 29,
        cardHolderName: 'Jane Roe',
        type: CardType.mastercard,
        bankName: 'Acme Bank',
      ),
    ];

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: CardHub(items: items),
        ),
      ),
    );
  }
}
