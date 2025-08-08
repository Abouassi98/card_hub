part of 'utils.dart';

/// An extension that adds functions to a [WidgetTester] object.
/// e.g. [pumpTestApp]
extension WidgetTesterX on WidgetTester {
  Future<void> pumpTestApp(Widget widget) {
    return pumpWidget(
      TestApp(widget: widget),
    );
  }
}
