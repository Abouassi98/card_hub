import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// notes:
// flutter_test supports an optional `testExecutable` that runs BEFORE any tests.
// We use it to:
// 1) Ensure the widget test binding is initialized
// 2) Provide a mock in-memory SharedPreferences, so code that reads/writes
//    preferences (inside the card_hub package) works in tests without a platform.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Ensure shared_preferences calls from card_hub do not require a platform.
  SharedPreferences.setMockInitialValues(const <String, Object>{});
  await testMain();
}
