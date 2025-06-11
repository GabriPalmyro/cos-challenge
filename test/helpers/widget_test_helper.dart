import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper class for widget testing
class WidgetTestHelper {
  /// Creates a testable widget wrapped with MaterialApp and necessary providers
  static Widget createTestableWidget({
    required Widget child,
    List<BlocProvider>? providers,
    ThemeData? theme,
  }) {
    Widget widget = child;

    if (providers != null && providers.isNotEmpty) {
      widget = MultiBlocProvider(
        providers: providers,
        child: widget,
      );
    }

    return MaterialApp(
      home: widget,
      theme: theme,
    );
  }

  /// Creates a basic Material App wrapper for simple widgets
  static Widget wrapWithMaterialApp(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  /// Helper to find widgets by key
  static Finder findByKey(String key) {
    return find.byKey(Key(key));
  }

  /// Helper to find widgets by text
  static Finder findByText(String text) {
    return find.text(text);
  }

  /// Helper to find widgets by type
  static Finder findByType<T>() {
    return find.byType(T);
  }

  /// Helper to verify if a widget exists
  static void expectWidgetExists(Finder finder) {
    expect(finder, findsOneWidget);
  }

  /// Helper to verify if a widget doesn't exist
  static void expectWidgetNotExists(Finder finder) {
    expect(finder, findsNothing);
  }

  /// Helper to verify widget count
  static void expectWidgetCount(Finder finder, int count) {
    expect(finder, findsNWidgets(count));
  }
}
