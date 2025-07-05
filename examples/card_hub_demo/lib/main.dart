import 'package:card_hub/card_hub.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Cards Motion Kit',
      home: CardHubMotionKitWidget(
        items: [
          CardHubModel(
              lastFour: 1,
              expirationMonth: 08,
              expirationYear: 2026,
              bankName: 'Bank Misr',
              type: CardType.mastercard,
              cardHolderName: 'Abouassi'),
          CardHubModel(
              lastFour: 1,
              expirationMonth: 09,
              expirationYear: 2027,
              bankName: 'Bank AlAhli',
              type: CardType.visa,
              cardHolderName: 'Abouassi2'),
          CardHubModel(
              lastFour: 1,
              expirationMonth: 02,
              expirationYear: 2025,
              bankName: 'Cairo Bank',
              type: CardType.visa,
              cardHolderName: 'Abouassi3'),
          CardHubModel(
              lastFour: 1,
              expirationMonth: 02,
              expirationYear: 2025,
              bankName: 'Cairo Bank',
              type: CardType.visa,
              cardHolderName: 'Abouassi3'),
          CardHubModel(
              lastFour: 1,
              expirationMonth: 02,
              expirationYear: 2025,
              bankName: 'Cairo Bank',
              type: CardType.visa,
              cardHolderName: 'Abouassi3'),
          CardHubModel(
              lastFour: 1,
              expirationMonth: 02,
              expirationYear: 2025,
              bankName: 'Cairo Bank',
              type: CardType.visa,
              cardHolderName: 'Abouassi3'),
          CardHubModel(
              lastFour: 1,
              expirationMonth: 02,
              expirationYear: 2025,
              bankName: 'Cairo Bank',
              type: CardType.visa,
              cardHolderName: 'Abouassi3'),
          CardHubModel(
              lastFour: 2,
              expirationMonth: 02,
              expirationYear: 2025,
              bankName: 'Cairo Bank',
              type: CardType.visa,
              cardHolderName: 'Abouassi3'),
          CardHubModel(
              lastFour: 2,
              expirationMonth: 02,
              expirationYear: 2025,
              bankName: 'Cairo Bank',
              type: CardType.visa,
              cardHolderName: 'Abouassi3'),
          CardHubModel(
              lastFour: 2,
              expirationMonth: 02,
              expirationYear: 2025,
              bankName: 'Cairo Bank',
              type: CardType.visa,
              cardHolderName: 'Abouassi3'),
        ],
      ),
    );
  }
}
