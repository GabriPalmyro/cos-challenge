import 'package:cos_challenge/app/features/home/presentation/page/car_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/car_model_fixture.dart';
import '../../../../../helpers/widget_test_helper.dart';

void main() {
  group('CarInfoPage', () {
    testWidgets('should display car information correctly', (tester) async {
      // Arrange
      final carInfo = CarModelFixture.validCarInfo();

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          CarInfoPage(carInfo: carInfo),
        ),
      );

      // Assert
      expect(find.text('Auction Car Info'), findsOneWidget);
      expect(find.text('${carInfo.make} ${carInfo.model}'), findsOneWidget);
      expect(find.text('\$${carInfo.price.toStringAsFixed(2)}'), findsOneWidget);
      expect(find.text('Origin: ${carInfo.origin}'), findsOneWidget);
    });

    testWidgets('should display positive customer feedback when true', (tester) async {
      // Arrange
      final carInfo = CarModelFixture.validCarInfo().copyWith(
        positiveCustomerFeedback: true,
      );

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          CarInfoPage(carInfo: carInfo),
        ),
      );

      // Assert
      expect(find.text('Positive Customer Feedback'), findsOneWidget);
    });

    testWidgets('should display negative customer feedback when false', (tester) async {
      // Arrange
      final carInfo = CarModelFixture.validCarInfo().copyWith(
        positiveCustomerFeedback: false,
      );

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          CarInfoPage(carInfo: carInfo),
        ),
      );

      // Assert
      expect(find.text('Negative Customer Feedback'), findsOneWidget);
    });

    testWidgets('should have app bar with back button', (tester) async {
      // Arrange
      final carInfo = CarModelFixture.validCarInfo();

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          CarInfoPage(carInfo: carInfo),
        ),
      );

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
    });

    testWidgets('should have proper layout structure', (tester) async {
      // Arrange
      final carInfo = CarModelFixture.validCarInfo();

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          CarInfoPage(carInfo: carInfo),
        ),
      );

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);

      // Verify column alignment
      final columnWidget = tester.widget<Column>(find.byType(Column));
      expect(columnWidget.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets('should display car price with proper formatting', (tester) async {
      // Arrange
      final carInfo = CarModelFixture.validCarInfo().copyWith(price: 25000);

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          CarInfoPage(carInfo: carInfo),
        ),
      );

      // Assert
      expect(find.text('\$25,000.00'), findsOneWidget);
    });

    testWidgets('should handle different car makes and models', (tester) async {
      // Arrange
      final carInfo = CarModelFixture.validCarInfo().copyWith(
        make: 'Toyota',
        model: 'Camry',
      );

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          CarInfoPage(carInfo: carInfo),
        ),
      );

      // Assert
      expect(find.text('Toyota Camry'), findsOneWidget);
    });

    testWidgets('should handle different origins', (tester) async {
      // Arrange
      final carInfo = CarModelFixture.validCarInfo().copyWith(
        origin: 'Japan',
      );

      // Act
      await tester.pumpWidget(
        WidgetTestHelper.wrapWithMaterialApp(
          CarInfoPage(carInfo: carInfo),
        ),
      );

      // Assert
      expect(find.text('Origin: Japan'), findsOneWidget);
    });
  });
}
