import 'package:card_hub/card_hub.dart';
import 'package:card_hub/src/services/card_hub_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// notes:
// This file contains small, focused tests ("unit tests") for pure functions
// inside CardHubService. Each test follows the simple pattern:
// 1) Arrange: create the inputs
// 2) Act: call the function under test
// 3) Assert: verify the result is what we expect

void main() {
  group('CardHubService', () {
    test('findDefaultCardIndex returns null when default id is null', () {
      // Arrange
      final items = [
        const CardHubModel(
          id: 'a',
          lastFour: 1111,
          expirationMonth: 1,
          expirationYear: 30,
          cardHolderName: 'A',
          type: CardType.visa,
          bankName: 'X',
        ),
      ];

      // Act
      final result = CardHubService.findDefaultCardIndex(items, null);

      // Assert
      expect(result, isNull);
    });

    test('reorderCardsByDefaultId returns a copy when default id is null', () {
      // Arrange
      final items = [
        const CardHubModel(
          id: 'a',
          lastFour: 1111,
          expirationMonth: 1,
          expirationYear: 30,
          cardHolderName: 'A',
          type: CardType.visa,
          bankName: 'X',
        ),
        const CardHubModel(
          id: 'b',
          lastFour: 2222,
          expirationMonth: 2,
          expirationYear: 30,
          cardHolderName: 'B',
          type: CardType.mastercard,
          bankName: 'Y',
        ),
      ];

      // Act
      final result = CardHubService.reorderCardsByDefaultId(items, null);

      // Assert: same content, different list instance
      expect(result, isNot(same(items)));
      expect(result.map((e) => e.id).toList(), ['a', 'b']);
    });
    test('reorderCardsByDefaultId moves default to index 0', () {
      // Arrange: create a list of cards where the default id is 'c'
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

      // Act: reorder the list so the default card ('c') becomes first
      final reordered = CardHubService.reorderCardsByDefaultId(items, 'c');

      // Assert: the first element should have id 'c', and the length stays the same
      expect(reordered.first.id, 'c');
      expect(reordered.length, items.length);
    });

    test('findDefaultCardIndex returns -1 when not found', () {
      // Arrange: a list that does not contain the requested id
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

      // Act & Assert: function should return -1 when id is missing
      expect(
        CardHubService.findDefaultCardIndex(items, 'not-exist'),
        equals(-1),
      );
    });

    test('palettesEqual compares maps shallowly', () {
      // Arrange: two maps with identical keys and list values
      final a = {
        'logo1': [const Color(0xFF000000), const Color(0xFFFFFFFF)],
      };
      final b = {
        'logo1': [const Color(0xFF000000), const Color(0xFFFFFFFF)],
      };

      // Act & Assert: the helper should treat these as equal
      expect(CardHubService.palettesEqual(a, b), isTrue);
    });
  });
}
