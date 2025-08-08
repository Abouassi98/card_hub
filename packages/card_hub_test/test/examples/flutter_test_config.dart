import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Ensure shared_preferences calls from card_hub do not require a platform.
  SharedPreferences.setMockInitialValues(const <String, Object>{});
  await testMain();
}
