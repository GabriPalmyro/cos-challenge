import 'dart:convert';

import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/presentation/widgets/similar_cars_by_vin_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../mocks/mocks.dart';

class MockCarModel extends Mock implements CarModel {}

void main() {
  group('SimilarCarsByVinModal Test', () {
    late List<CarModel> mockSimilarCars;

    setUp(() {
      mockSimilarCars = jsonDecode(multipleOptionResponse).map<CarModel>((car) => CarModel.fromJson(car)).toList();
    });

    testWidgets('should display modal title and close button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SimilarCarsByVinModal(similarCars: mockSimilarCars),
          ),
        ),
      );

      expect(find.text('Similar Cars by VIN'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('should display list of similar cars', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SimilarCarsByVinModal(similarCars: mockSimilarCars),
          ),
        ),
      );

      expect(find.text('Toyota GT 86 Basis'), findsWidgets);
    });

    testWidgets('should display VIN similarity percentages', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SimilarCarsByVinModal(similarCars: mockSimilarCars),
          ),
        ),
      );

      expect(find.text('VIN Similarity: 85.00%'), findsOneWidget);
      expect(find.text('VIN Similarity: 50.00%'), findsOneWidget);
      expect(find.text('VIN Similarity: 0.00%'), findsOneWidget);
    });

    testWidgets('should display external IDs', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SimilarCarsByVinModal(similarCars: mockSimilarCars),
          ),
        ),
      );

      expect(find.text('DE001-018601450020001'), findsOneWidget);
      expect(find.text('DE002-018601450020001'), findsOneWidget);
      expect(find.text('DE003-018601450020001'), findsOneWidget);
    });

    testWidgets('should handle empty list of similar cars', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SimilarCarsByVinModal(similarCars: []),
          ),
        ),
      );

      expect(find.text('Similar Cars by VIN'), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
    });
  });
}
