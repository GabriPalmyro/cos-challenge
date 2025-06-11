import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestHelper {
  TestHelper._();

  Future<void> loginHelper(WidgetTester tester) async {
    // Verify we're on the login page by finding email input
    final emailInput = find.byType(TextFormField).first;
    expect(emailInput, findsOneWidget);

    // Find the name input (second TextFormField)
    final nameInput = find.byType(TextFormField).last;
    expect(nameInput, findsOneWidget);

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
  }
}
