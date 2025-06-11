import 'package:cos_challenge/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../utils/test_helper.dart';
import '../utils/test_settings.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Success Integration Tests', () {
    setUpAll(() async {
      await configureIntegrationApp();
    });

    testWidgets('Should display car information when search is successful', (tester) async {
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      await TestHelper.loginHelper(tester);

      await tester.pumpAndSettle();

      final vinTextField = find.byType(TextFormField);
      expect(vinTextField, findsOneWidget);

      // Enter a valid VIN
      await tester.enterText(vinTextField, '1HGCM82633A123456');
      await tester.pump();
      // Find and tap the search button
      final searchButton = find.text('Search');
      expect(searchButton, findsOneWidget);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      // Verify that car information is displayed
      expect(find.text('Car Information'), findsOneWidget);
    });
  });
}
