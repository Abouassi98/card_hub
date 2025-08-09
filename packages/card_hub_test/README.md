# card_hub_test

A small companion test package for the `card_hub` package. It contains simple, well-commented unit and widget tests suitable for beginners.

## Folder structure

- `lib/src/simple_cardhub_example.dart`
  - Minimal example widget used by example tests.
- `test/unit/`
  - Focused unit tests for pure functions (e.g., `CardHubService`).
- `test/examples/`
  - A tiny `TestApp` wrapper and an example widget test.
- `test/utils/utils.dart`
  - Shared helpers for tests (e.g., `WidgetTesterX.pumpTestApp`).
- `dart_test.yaml`
  - Test configuration (tags, platforms).

## How to run tests

- All tests (recommended):
  ```bash
  flutter test
  ```
- Exclude performance tests (if any are added in the future):
  ```bash
  flutter test --exclude-tags perf
  ```
- Only performance tests (if present):
  ```bash
  flutter test --tags perf
  ```

> Note: Performance tests can be slow; we keep or mark them as skipped by default.

## Writing a new unit test

1. Create a file in `test/unit/`, for example: `my_service_test.dart`.
2. Follow the Arrange–Act–Assert pattern:
   ```dart
   test('does something', () {
     // Arrange
     final input = ...;

     // Act
     final result = myFunction(input);

     // Assert
     expect(result, ...);
   });
   ```

## Writing a new widget test

1. Import the test utilities and your widget.
2. Use the `pumpTestApp` helper to render your widget inside a `MaterialApp`:
   ```dart
   import 'package:flutter_test/flutter_test.dart';
   import 'package:card_hub_test/test/utils/utils.dart';

   testWidgets('renders MyWidget', (tester) async {
     await tester.pumpTestApp(MyWidget());
     await tester.pumpAndSettle();
     expect(find.byType(MyWidget), findsOneWidget);
   });
   ```

## Global test setup

`test/examples/flutter_test_config.dart` uses `testExecutable` to:
- Initialize the widget test binding.
- Provide in-memory `SharedPreferences` mocking so code that reads/writes prefs runs in tests without a platform.

## Tips

- Keep tests short and focused on one behavior.
- Prefer pure functions for unit tests; keep UI tests minimal and deterministic.
- Share small helpers via `test/utils/utils.dart`.

## Palette extraction test seam (advanced)

Some unit tests exercise palette extraction in `CardHubService` without real images.

- The service method `CardHubService.extractColorPalettes()` accepts an optional
  `extractor(ByteData, String)` test seam. In production code you can ignore this
  parameter; tests pass a fake extractor to return a predictable palette.
- This enables verifying cache behavior deterministically (no image decoding).
- See: `test/unit/card_hub_service_extract_test.dart` for examples, including a
  test that calls the method twice and asserts zero extra asset loads on the
  second call when the cache is used.

## Troubleshooting

- If you see dependency warnings when running tests, that’s normal for local development. You can run `flutter pub outdated` to explore updates if needed.
- If tests fail due to missing assets or platform services, wrap your widget under test with `TestApp` and/or mock required services in the setup.
