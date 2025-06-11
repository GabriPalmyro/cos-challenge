import 'package:cos_challenge/app/app_widget.dart';
import 'package:cos_challenge/app/common/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppWidget', () {
    testWidgets('should create MaterialApp with correct configuration', (tester) async {
      // Act
      await tester.pumpWidget(const AppWidget());

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      
      expect(materialApp.title, equals('COS Challenge'));
      expect(materialApp.themeMode, equals(ThemeMode.dark));
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });

    testWidgets('should have dark theme configured', (tester) async {
      // Act
      await tester.pumpWidget(const AppWidget());

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      final theme = materialApp.theme;
      
      expect(theme, isNotNull);
      expect(theme!.brightness, equals(Brightness.dark));
      expect(theme.useMaterial3, isTrue);
    });

    testWidgets('should set initial route to splash', (tester) async {
      // Act
      await tester.pumpWidget(const AppWidget());

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.initialRoute, equals(Routes.splash));
    });

    testWidgets('should configure route generation', (tester) async {
      // Act
      await tester.pumpWidget(const AppWidget());

      // Assert
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.onGenerateRoute, equals(AppRouter.onGenerateRoute));
    });
  });
}
