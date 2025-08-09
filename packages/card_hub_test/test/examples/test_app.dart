import 'package:flutter/material.dart';

// notes:
// Many widgets expect to live under a MaterialApp (theme, Navigator, etc.).
// In widget tests we wrap the widget under test with this tiny `TestApp`
// so it renders correctly without needing a full application.
class TestApp extends StatelessWidget {
  const TestApp({required this.widget, super.key});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget,
    );
  }
}
