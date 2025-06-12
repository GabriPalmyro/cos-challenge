import 'dart:convert';

import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/presentation/page/car_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  group('CarInfoPage Widget Tests', () {
    late CarInfoModel testCarInfo;

    setUp(() {
      testCarInfo = CarInfoModel.fromJson(jsonDecode(carInfoResponse));
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: CarInfoPage(carInfo: testCarInfo),
      );
    }

    testWidgets('should display car placeholder image', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byIcon(Icons.directions_car), findsOneWidget);

      final container = tester.widget<Container>(
        find
            .ancestor(
              of: find.byIcon(Icons.directions_car),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(container.decoration, isA<BoxDecoration>());
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.grey[300]);
      expect(decoration.borderRadius, BorderRadius.circular(8));
    });

    testWidgets('should display car information correctly', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('150,00 €'), findsOneWidget);
      expect(find.text('Positive Customer Feedback'), findsOneWidget);
      expect(find.text('Auction Car Info'), findsOneWidget);
      expect(find.text('Positive Customer Feedback'), findsOneWidget);
      expect(find.text('Origin: AUCTION'), findsOneWidget);
      expect(find.text('ID: 123123'), findsOneWidget);
    });

    testWidgets('should display elements in correct order', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);

      // Check that all main elements are present in the column
      expect(find.descendant(of: find.byType(Column), matching: find.byType(Container)), findsOneWidget); // Car image container
      expect(find.descendant(of: find.byType(Column), matching: find.text('Toyota GT 86 Basis')), findsOneWidget);
      expect(find.descendant(of: find.byType(Column), matching: find.text('150,00 €')), findsOneWidget);
      expect(find.descendant(of: find.byType(Column), matching: find.text('Positive Customer Feedback')), findsOneWidget);
      expect(find.descendant(of: find.byType(Column), matching: find.text('Origin: AUCTION')), findsOneWidget);
      expect(find.descendant(of: find.byType(Column), matching: find.text('ID: 123123')), findsOneWidget);
    });
  });
}
