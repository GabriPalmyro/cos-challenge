import 'package:cos_challenge/app/features/home/presentation/widgets/car_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/widget_test_helper.dart';

void main() {
  group('CarSearchLoadingWidget', () {
    testWidgets('should display a CircularProgressIndicator', (tester) async {
      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          const CarSearchLoadingWidget(),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should have proper sizing based on screen height', (tester) async {
      // Arrange
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          const CarSearchLoadingWidget(),
        ),
      );

      // Assert
      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(CarSearchLoadingWidget),
          matching: find.byType(SizedBox),
        ),
      );

      // The widget should take 60% of screen height
      expect(sizedBox.height, equals(800 * 0.6));
    });

    testWidgets('should center the CircularProgressIndicator', (tester) async {
      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          const CarSearchLoadingWidget(),
        ),
      );

      // Assert
      final center = tester.widget<Center>(
        find.descendant(
          of: find.byType(CarSearchLoadingWidget),
          matching: find.byType(Center),
        ),
      );

      expect(center, isNotNull);
      
      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.descendant(
          of: find.byType(Center),
          matching: find.byType(CircularProgressIndicator),
        ),
      );

      expect(progressIndicator, isNotNull);
    });

    testWidgets('should have the correct widget structure', (tester) async {
      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          const CarSearchLoadingWidget(),
        ),
      );

      // Assert
      expect(find.byType(CarSearchLoadingWidget), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
