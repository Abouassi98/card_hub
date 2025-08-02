import 'package:flutter/material.dart';

import '../utils/enumerations.dart';

/// Represents a credit card model.
@immutable
class CardHubModel {
  /// Constructs a [CardHubModel].
  const CardHubModel({
    required this.id,
    required this.lastFour,
    required this.expirationMonth,
    required this.expirationYear,
    required this.cardHolderName,
    required this.type,
    required this.bankName,
    this.logoAssetPath,
    this.cardColor,
    this.onCardTap,
  }) : assert(!(logoAssetPath != null && cardColor != null), 
            'Cannot provide both logoAssetPath and cardColor');
  /// Constructs a [CardHubModel].
  /// A unique identifier for the card.
  final String id;
  /// A string indicating number on the card.
  final int lastFour;
  /// The expiration month of the credit card.
  final int expirationMonth;
  /// The expiration year of the credit card.
  final int expirationYear;
  /// A string indicating name of the card holder.
  final String cardHolderName;
  /// Sets type of the card. An small image is shown based on selected type
  /// of the card at bottom right corner. If this is set to null then image
  /// shown automatically based on credit card number.
  final CardType type;
  /// A string indicating name of the bank.
  final String bankName;
  /// The local asset path for the card's brand logo (e.g., 'assets/logos/netflix.png').
  /// If provided, the card will be themed based on this logo.
  final String? logoAssetPath;
  /// The color of the card. If provided, the card will be themed based on this color.
  final Color? cardColor;
  /// Optional callback function that is triggered when a card is selected.
  final void Function(CardHubModel model)? onCardTap;
            
  /// Creates a copy of this [CardHubModel] with the given fields replaced with new values.
  CardHubModel copyWith({
    String? id,
    int? lastFour,
    int? expirationMonth,
    int? expirationYear,
    String? cardHolderName,
    CardType? type,
    String? bankName,
    String? logoAssetPath,
    Color? cardColor,
    void Function(CardHubModel)? onCardTap,
  }) {
    return CardHubModel(
      id: id ?? this.id,
      lastFour: lastFour ?? this.lastFour,
      expirationMonth: expirationMonth ?? this.expirationMonth,
      expirationYear: expirationYear ?? this.expirationYear,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      type: type ?? this.type,
      bankName: bankName ?? this.bankName,
      logoAssetPath: logoAssetPath ?? this.logoAssetPath,
      cardColor: cardColor ?? this.cardColor,
      onCardTap: onCardTap ?? this.onCardTap,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is CardHubModel &&
        other.id == id &&
        other.lastFour == lastFour &&
        other.expirationMonth == expirationMonth &&
        other.expirationYear == expirationYear &&
        other.cardHolderName == cardHolderName &&
        other.type == type &&
        other.bankName == bankName &&
        other.logoAssetPath == logoAssetPath &&
        other.cardColor == cardColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      lastFour,
      expirationMonth,
      expirationYear,
      cardHolderName,
      type,
      bankName,
      logoAssetPath,
      cardColor,
    );
  }
  
  @override
  String toString() {
    return 'CardHubModel(id: $id, lastFour: $lastFour, expirationMonth: $expirationMonth, '
        'expirationYear: $expirationYear, cardHolderName: $cardHolderName, '
        'type: $type, bankName: $bankName, logoAssetPath: $logoAssetPath, '
        'cardColor: $cardColor)'; 
  }
}
