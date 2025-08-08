import 'package:card_hub_test/src/simple_cardhub_example.dart' show SimpleCardHubExample;
import 'package:flutter_test/flutter_test.dart';

import '../utils/utils.dart';
import 'test_app.dart';
void main() {
  testWidgets('Simple CardHub Example renders', (WidgetTester tester) async {
    // GIVEN
    await tester.pumpTestApp(const SimpleCardHubExample());

    // THEN
    expect(find.byType(TestApp), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
