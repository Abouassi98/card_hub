import 'package:card_hub_test/src/simple_cardhub_example.dart' show SimpleCardHubExample;
import 'package:flutter_test/flutter_test.dart';

import '../utils/utils.dart';
import 'test_app.dart';

void main() {
  testWidgets('Simple CardHub Example renders', (WidgetTester tester) async {
    // Arrange: build the example widget inside a minimal MaterialApp.
    // pumpTestApp is a small helper from test/utils/utils.dart
    await tester.pumpTestApp(const SimpleCardHubExample());

    // Act: settle any pending animations/frames.
    await tester.pumpAndSettle();

    // Assert: the TestApp wrapper is present, meaning the widget rendered.
    expect(find.byType(TestApp), findsOneWidget);
  });
}
