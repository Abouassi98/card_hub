import 'package:card_hub/card_hub.dart';
import 'package:card_hub/src/services/card_hub_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardHubService', () {
    test('reorderCardsByDefaultId moves default to index 0', () {
      final items = [
        const CardHubModel(
            id: 'a',
            lastFour: 1111,
            expirationMonth: 1,
            expirationYear: 30,
            cardHolderName: 'A',
            type: CardType.visa,
            bankName: 'X'),
        const CardHubModel(
            id: 'b',
            lastFour: 2222,
            expirationMonth: 2,
            expirationYear: 30,
            cardHolderName: 'B',
            type: CardType.mastercard,
            bankName: 'Y'),
        const CardHubModel(
            id: 'c',
            lastFour: 3333,
            expirationMonth: 3,
            expirationYear: 30,
            cardHolderName: 'C',
            type: CardType.visa,
            bankName: 'Z'),
      ];
      final reordered = CardHubService.reorderCardsByDefaultId(items, 'c');
      expect(reordered.first.id, 'c');
      expect(reordered.length, items.length);
    });

    test('findDefaultCardIndex returns -1 when not found', () {
      final items = [
        const CardHubModel(
            id: 'a',
            lastFour: 1111,
            expirationMonth: 1,
            expirationYear: 30,
            cardHolderName: 'A',
            type: CardType.visa,
            bankName: 'X'),
      ];
      expect(CardHubService.findDefaultCardIndex(items, 'not-exist'), equals(-1));
    });

    test('palettesEqual compares maps shallowly', () {
      final a = {
        'logo1': [const Color(0xFF000000), const Color(0xFFFFFFFF)],
      };
      final b = {
        'logo1': [const Color(0xFF000000), const Color(0xFFFFFFFF)],
      };
      expect(CardHubService.palettesEqual(a, b), isTrue);
    });
  });
}
