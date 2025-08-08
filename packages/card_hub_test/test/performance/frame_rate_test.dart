@Tags(['perf'])
import 'dart:math';

import 'package:card_hub/card_hub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Register a mock asset bundle to avoid real asset I/O in perf tests.
    final ByteData imageData = ByteData(0);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
      return imageData;
    });
  });

  testWidgets('CardHub frame rate test under high load', (WidgetTester tester) async {
    // Create a number of card items to simulate high load
    final List<CardHubModel> items = List.generate(
      20,
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

    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SizedBox(),
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: CardHub(items: items),
        ),
      ),
    );

    // Warm-up frames
    for (int i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }

    // Measure frame build times during rapid interactions
    final Stopwatch stopwatch = Stopwatch();
    int frameCount = 0;
    double totalBuildTime = 0;

    for (int i = 0; i < 20; i++) {
      final int randomIndex = Random().nextInt(items.length);

      final cardHubFinder = find.byType(CardHub);
      if (cardHubFinder.evaluate().isNotEmpty) {
        final Rect rect = tester.getRect(cardHubFinder);
        // Tap at different positions within the widget to change selection
        await tester.tapAt(Offset(
          rect.left + rect.width * (0.2 + (randomIndex % 5) * 0.15),
          rect.top + rect.height * 0.5,
        ));
      }

      stopwatch
        ..reset()
        ..start();

      // Pump a single frame and measure time
      await tester.pump();

      final double frameBuildTime = stopwatch.elapsedMilliseconds.toDouble();
      totalBuildTime += frameBuildTime;
      frameCount++;

      // Advance a few frames to progress animations deterministically
      for (int i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 16));
      }
    }

    final double averageFrameBuildTime = totalBuildTime / frameCount;
    // Log for local visibility
    // ignore: avoid_print
    print('Average frame build time: ${averageFrameBuildTime.toStringAsFixed(2)} ms');
    // 16ms ~ 60fps
    expect(
      averageFrameBuildTime < 16.0,
      isTrue,
      reason:
          'Average frame build time ($averageFrameBuildTime ms) exceeds 16ms threshold for 60fps',
    );
  });
}
