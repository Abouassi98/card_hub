// ignore_for_file: public_member_api_docs

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
      title: 'Credit Hub',
      home: CardHubMotionKitWidget(
        items: [
          CardHubModel(
            id: '1',
            lastFour: 1,
            expirationMonth: 08,
            expirationYear: 2026,
            bankName: 'Bank Misr',
            type: CardType.mastercard,
            logoAssetPath: 'assets/images/mastercard.png',
            cardHolderName: 'Abouassi',
          ),
        ],
      ),
    );
  }
}
