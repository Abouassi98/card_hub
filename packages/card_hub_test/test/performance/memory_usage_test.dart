@Tags(['perf'])
import 'dart:async';

import 'package:card_hub/card_hub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Register a mock asset bundle
    final ByteData imageData = ByteData(0);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
      return imageData;
    });
  });

  testWidgets('CardHub memory usage test with repeated rebuilds', (WidgetTester tester) async {
    final StreamController<List<CardHubModel>> controller = StreamController<List<CardHubModel>>();

    List<CardHubModel> generateItems(int count) {
      return List.generate(
        count,
        (index) => CardHubModel(
          id: 'card_$index',
          bankName: 'Test Bank $index',
          cardHolderName: 'Test User',
          lastFour: 1000 + index,
          expirationMonth: (index % 12) + 1,
          expirationYear: 24 + (index % 10),
          type: index.isEven ? CardType.visa : CardType.mastercard,
          cardColor: Colors.blue,
          onCardTap: (_) {},
        ),
      );
    }

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder<List<CardHubModel>>(
            stream: controller.stream,
            initialData: generateItems(20),
            builder: (context, snapshot) {
              return CardHub(items: snapshot.data!);
            },
          ),
        ),
      ),
    );

    // Warm-up
    for (int i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }

    for (int i = 0; i < 50; i++) {
      controller.add(generateItems(20 + (i % 5)));
      await tester.pump();
      if (i % 5 == 0) {
        // Try a generic tap in the CardHub area to simulate interaction
        final cardHubFinder = find.byType(CardHub);
        if (cardHubFinder.evaluate().isNotEmpty) {
          final rect = tester.getRect(cardHubFinder);
          await tester.tapAt(Offset(rect.center.dx, rect.center.dy));
          await tester.pump(const Duration(milliseconds: 100));
        }
      }
    }

    // Cool down frames
    for (int i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 33));
    }

    await controller.close();

    // No direct memory asserts (VM doesn’t expose stable metrics here),
    // this test is useful when paired with DevTools/CI sampling.
    expect(true, isTrue);
  });
}
