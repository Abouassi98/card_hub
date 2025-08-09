import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../examples/test_app.dart';

// notes:
// Utilities used across widget tests live here. Keeping helpers in one file
// makes tests shorter and easier to read.
//
// Below is an extension method on WidgetTester that pumps a minimal app
// shell around the widget under test.

/// An extension that adds functions to a [WidgetTester] object.
/// e.g. [pumpTestApp]
extension WidgetTesterX on WidgetTester {
  /// Wraps [widget] with a basic [MaterialApp] so it can render in tests.
  Future<void> pumpTestApp(Widget widget) {
    return pumpWidget(
      TestApp(widget: widget),
    );
  }
}
