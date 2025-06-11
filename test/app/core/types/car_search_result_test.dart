import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/car_model_fixture.dart';

void main() {
  group('CarSearchResult', () {
    group('CarSearchSuccess', () {
      test('should create success result with car info', () {
        // Arrange
        final carInfo = CarModelFixture.validCarInfo();

        // Act
        final result = CarSearchSuccess(carInfo);

        // Assert
        expect(result.carInfo, equals(carInfo));
        expect(result, isA<CarSearchResult>());
      });

      test('should support equality comparison', () {
        // Arrange
        final carInfo = CarModelFixture.validCarInfo();
        final result1 = CarSearchSuccess(carInfo);
        final result2 = CarSearchSuccess(carInfo);

        // Act & Assert
        expect(result1.carInfo.id, equals(result2.carInfo.id));
        expect(result1.carInfo.make, equals(result2.carInfo.make));
        expect(result1.carInfo.model, equals(result2.carInfo.model));
      });
    });

    group('CarMultipleChoices', () {
      test('should create multiple choices result with car list', () {
        // Arrange
        final cars = [
          CarModelFixture.validCar(),
          const CarModel(
            make: 'Honda',
            model: 'Civic',
            containerName: 'container-2',
            similarity: 90,
            externalId: 'ext-2',
          ),
        ];

        // Act
        final result = CarMultipleChoices(cars);

        // Assert
        expect(result.carsList, equals(cars));
        expect(result.carsList.length, 2);
        expect(result, isA<CarSearchResult>());
      });

      test('should handle empty car list', () {
        // Arrange
        final cars = <CarModel>[];

        // Act
        final result = CarMultipleChoices(cars);

        // Assert
        expect(result.carsList, isEmpty);
        expect(result, isA<CarSearchResult>());
      });
    });

    group('CarSearchFailure', () {
      test('should create failure result with error', () {
        // Arrange
        final error = CarsNotFoundError(message: 'Test error');

        // Act
        final result = CarSearchFailure(error);

        // Assert
        expect(result.error, equals(error));
        expect(result.error.message, 'Test error');
        expect(result, isA<CarSearchResult>());
      });

      test('should handle different error types', () {
        // Arrange
        final error = CarsNotFoundError(message: 'Custom error message');

        // Act
        final result = CarSearchFailure(error);

        // Assert
        expect(result.error, isA<CarsNotFoundError>());
        expect(result.error.message, 'Custom error message');
      });
    });
  });
}
