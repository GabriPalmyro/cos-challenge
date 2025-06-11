import 'package:cos_challenge/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../utils/test_settings.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Success Integration Tests', () {
    setUpAll(() async {
      await configureIntegrationApp();
    });

    testWidgets('Should navigate to login page and perform successful login', (tester) async {
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      // Wait for splash screen to complete and navigate to login
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify we're on the login page by finding email input
      final textFields = find.byType(TextFormField);
      expect(textFields, findsAtLeastNWidgets(2));

      final emailInput = textFields.at(0);
      final nameInput = textFields.at(1);

      // Enter valid email
      await tester.enterText(emailInput, 'test@example.com');
      await tester.pump();

      // Enter valid name
      await tester.enterText(nameInput, 'Test User');
      await tester.pump();

      // Find and tap the login button
      final loginButton = find.text('Login');
      expect(loginButton, findsOneWidget);

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify successful login by checking if we navigated away from login
      // The login page should no longer be visible after successful login
      expect(find.text('Welcome back'), findsOneWidget);
    });
  });
}
