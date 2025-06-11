import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/car_model_fixture.dart';

void main() {
  group('CarModel', () {
    group('fromJson', () {
      test('should create CarModel from valid JSON', () {
        // Arrange
        final json = CarModelFixture.validCarJson();

        // Act
        final result = CarModel.fromJson(json);

        // Assert
        expect(result.make, equals('Toyota'));
        expect(result.model, equals('Camry'));
        expect(result.containerName, equals('test-container'));
        expect(result.similarity, equals(95));
        expect(result.externalId, equals('ext-123'));
      });

      test('should create CarModel with all required fields', () {
        // Arrange
        final json = {
          'make': 'Honda',
          'model': 'Civic',
          'containerName': 'container-honda',
          'similarity': 90,
          'externalId': 'honda-123',
        };

        // Act
        final result = CarModel.fromJson(json);

        // Assert
        expect(result.make, equals('Honda'));
        expect(result.model, equals('Civic'));
        expect(result.containerName, equals('container-honda'));
        expect(result.similarity, equals(90));
        expect(result.externalId, equals('honda-123'));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final car1 = CarModelFixture.validCar();
        final car2 = CarModelFixture.validCar();

        // Act & Assert
        expect(car1, equals(car2));
        expect(car1.hashCode, equals(car2.hashCode));
      });

      test('should not be equal when properties are different', () {
        // Arrange
        final car1 = CarModelFixture.validCar();
        final car2 = const CarModel(
          make: 'Honda',
          model: 'Civic',
          containerName: 'different-container',
          similarity: 85,
          externalId: 'different-id',
        );

        // Act & Assert
        expect(car1, isNot(equals(car2)));
      });
    });

    group('props', () {
      test('should include all properties in props list', () {
        // Arrange
        final car = CarModelFixture.validCar();

        // Act
        final props = car.props;

        // Assert
        expect(props, contains(car.make));
        expect(props, contains(car.model));
        expect(props, contains(car.containerName));
        expect(props, contains(car.similarity));
        expect(props, contains(car.externalId));
        expect(props.length, equals(5));
      });
    });
  });
}
