import 'package:cos_challenge/app/features/home/presentation/widgets/no_car_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/widget_test_helper.dart';

void main() {
  group('NoCarFoundWidget', () {
    testWidgets('should display no car found message with search icon', (tester) async {
      // Arrange
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          const NoCarFoundWidget(),
        ),
      );

      // Act & Assert
      expect(find.byIcon(Icons.search_off), findsOneWidget);
      expect(find.text('No car found with the provided VIN.'), findsOneWidget);

      // Verify icon properties
      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.search_off));
      expect(iconWidget.size, 64);
      expect(iconWidget.color, Colors.grey);
    });

    testWidgets('should have correct layout structure', (tester) async {
      // Arrange
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          const NoCarFoundWidget(),
        ),
      );

      // Act & Assert
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);

      // Verify column alignment
      final columnWidget = tester.widget<Column>(find.byType(Column));
      expect(columnWidget.mainAxisAlignment, MainAxisAlignment.center);
    });

    testWidgets('should have proper height based on screen size', (tester) async {
      // Arrange
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          const NoCarFoundWidget(),
        ),
      );
      await tester.pumpAndSettle();

      // Act & Assert
      final sizedBoxWidget = tester.widget<SizedBox>(find.byType(SizedBox).first);
      final screenHeight = MediaQuery.of(tester.element(find.byType(NoCarFoundWidget))).size.height;
      expect(sizedBoxWidget.height, screenHeight * 0.6);
    });
  });
}
