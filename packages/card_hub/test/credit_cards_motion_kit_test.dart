import 'package:card_hub/card_hub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Consolidated basic behavior tests for CardHub (non-golden).
/// Detailed goldens and performance tests live in the harness package:
/// `packages/card_hub_test/`.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap(Widget child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: child),
      );

  CardHubModel model({
    required String id,
    required String bank,
    required int last4,
    required int mm,
    required int yy,
    required CardType type,
  }) =>
      CardHubModel(
        id: id,
        bankName: bank,
        cardHolderName: 'Test User',
        lastFour: last4,
        expirationMonth: mm,
        expirationYear: yy,
        type: type,
        cardColor: Colors.blue,
        onCardTap: (_) {},
      );

  testWidgets('renders CardHub with two items without exceptions', (tester) async {
    final items = [
      model(id: 'a', bank: 'Bank A', last4: 1111, mm: 1, yy: 30, type: CardType.visa),
      model(id: 'b', bank: 'Bank B', last4: 2222, mm: 2, yy: 31, type: CardType.mastercard),
    ];

    await tester.pumpWidget(wrap(CardHub(items: items)));
    await tester.pump();

    expect(find.byType(CardHub), findsOneWidget);
  });

  testWidgets('tap inside CardHub does not throw and triggers a frame', (tester) async {
    final items = [
      model(id: 'a', bank: 'Bank A', last4: 1111, mm: 1, yy: 30, type: CardType.visa),
      model(id: 'b', bank: 'Bank B', last4: 2222, mm: 2, yy: 31, type: CardType.mastercard),
    ];

    await tester.pumpWidget(wrap(CardHub(items: items)));
    await tester.pump();

    final hub = find.byType(CardHub);
    expect(hub, findsOneWidget);

    final rect = tester.getRect(hub);
    await tester.tapAt(rect.center);
    await tester.pump(const Duration(milliseconds: 16));

    // If we reached here without exceptions, consider it success.
    expect(true, isTrue);
  });
}
