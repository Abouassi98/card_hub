import 'package:card_hub/card_hub.dart';
import 'package:card_hub/src/services/card_hub_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CardHubService.extractColorPalettes (with mocked bundle)', () {
    // notes:
    // We mock the 'flutter/assets' channel so calls to rootBundle.load do not
    // hit the real filesystem. For cache behavior, we also use the optional
    // extractor seam exposed by CardHubService to return a predictable palette
    // (no real image decoding needed).
    int loadCalls = 0;

    setUp(() {
      loadCalls = 0;
      // Mock the asset channel so rootBundle.load returns empty bytes
      final ByteData empty = ByteData(0);
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (ByteData? message) async {
        loadCalls++;
        return empty;
      });
    });

    tearDown(() {
      // Remove the mock handler
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', null);
    });

    test('loads each unique non-null logo path once (fallback reuses bytes)', () async {
      // Arrange: two items with the same logo path and one with a different path
      final items = <CardHubModel>[
        const CardHubModel(
          id: 'a',
          lastFour: 1111,
          expirationMonth: 1,
          expirationYear: 30,
          cardHolderName: 'A',
          type: CardType.visa,
          bankName: 'X',
          logoAssetPath: 'assets/logo_a.png',
        ),
        const CardHubModel(
          id: 'b',
          lastFour: 2222,
          expirationMonth: 2,
          expirationYear: 30,
          cardHolderName: 'B',
          type: CardType.mastercard,
          bankName: 'Y',
          logoAssetPath: 'assets/logo_a.png', // duplicate path
        ),
        const CardHubModel(
          id: 'c',
          lastFour: 3333,
          expirationMonth: 3,
          expirationYear: 30,
          cardHolderName: 'C',
          type: CardType.visa,
          bankName: 'Z',
          logoAssetPath: 'assets/logo_b.png',
        ),
      ];

      // Act: attempt extraction; with empty bytes, extractors likely fail,
      // but we only assert on load invocations
      await CardHubService.extractColorPalettes(items);

      // Assert: two unique paths -> each loaded once (fallback reuses same bytes)
      expect(loadCalls, 2);
    });

    test('skips null logo paths', () async {
      // Arrange: one item with null logo path
      final items = <CardHubModel>[
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
      await CardHubService.extractColorPalettes(items);

      // Assert: no asset loads performed
      expect(loadCalls, 0);
    });

    test('caches palettes across calls when extractor provided', () async {
      // Arrange: two items share same path
      final items = <CardHubModel>[
        const CardHubModel(
          id: 'a',
          lastFour: 1111,
          expirationMonth: 1,
          expirationYear: 30,
          cardHolderName: 'A',
          type: CardType.visa,
          bankName: 'X',
          logoAssetPath: 'assets/shared_logo.png',
        ),
        const CardHubModel(
          id: 'b',
          lastFour: 2222,
          expirationMonth: 2,
          expirationYear: 30,
          cardHolderName: 'B',
          type: CardType.mastercard,
          bankName: 'Y',
          logoAssetPath: 'assets/shared_logo.png',
        ),
      ];

      // notes: Use the test-only extractor seam to make caching deterministic.
      // A fake extractor that always returns a fixed palette
      Future<List<Color>> extractor(ByteData bytes, String path) async {
        // Return 3 colors to satisfy the service expectations
        return const [Color(0xFF000000), Color(0xFF111111), Color(0xFF222222)];
      }

      // Act: first call populates cache (1 load)
      loadCalls = 0;
      await CardHubService.extractColorPalettes(items, extractor: extractor);
      expect(loadCalls, 1);

      // Act: second call should use cache (no new loads)
      loadCalls = 0;
      await CardHubService.extractColorPalettes(items, extractor: extractor);
      expect(loadCalls, 0);
    });
  });
}
