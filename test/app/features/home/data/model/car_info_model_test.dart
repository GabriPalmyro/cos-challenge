import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/car_model_fixture.dart';

void main() {
  group('CarInfoModel', () {
    group('fromJson', () {
      test('should create CarInfoModel from valid JSON', () {
        // Arrange
        final json = CarModelFixture.validCarInfoJson();

        // Act
        final result = CarInfoModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.feedback, equals('Good condition'));
        expect(result.make, equals('Toyota'));
        expect(result.model, equals('Camry'));
        expect(result.externalId, equals('ext-123'));
        expect(result.sellerUser, equals('seller123'));
        expect(result.price, equals(25000));
        expect(result.positiveCustomerFeedback, equals(true));
      });

      test('should handle all fields correctly', () {
        // Arrange
        final json = {
          'id': 2,
          'feedback': 'Excellent',
          'valuatedAt': '2023-02-01T00:00:00Z',
          'requestedAt': '2023-02-01T00:00:00Z',
          'createdAt': '2023-02-01T00:00:00Z',
          'updatedAt': '2023-02-01T00:00:00Z',
          'make': 'Honda',
          'model': 'Accord',
          'externalId': 'honda-456',
          '_fk_sellerUser': 'seller456',
          'price': 30000,
          'positiveCustomerFeedback': false,
          '_fk_uuid_auction': 'auction-456',
          'inspectorRequestedAt': '2023-02-01T00:00:00Z',
          'origin': 'private',
          'estimationRequestId': 'est-456',
        };

        // Act
        final result = CarInfoModel.fromJson(json);

        // Assert
        expect(result.id, equals(2));
        expect(result.feedback, equals('Excellent'));
        expect(result.make, equals('Honda'));
        expect(result.model, equals('Accord'));
        expect(result.price, equals(30000));
        expect(result.positiveCustomerFeedback, equals(false));
        expect(result.origin, equals('private'));
      });
    });

    group('toJson', () {
      test('should convert CarInfoModel to JSON correctly', () {
        // Arrange
        final carInfo = CarModelFixture.validCarInfo();

        // Act
        final result = carInfo.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['feedback'], equals('Good condition'));
        expect(result['make'], equals('Toyota'));
        expect(result['model'], equals('Camry'));
        expect(result['externalId'], equals('ext-123'));
        expect(result['_fk_sellerUser'], equals('seller123'));
        expect(result['price'], equals(25000));
        expect(result['positiveCustomerFeedback'], equals(true));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final carInfo1 = CarModelFixture.validCarInfo();
        final carInfo2 = CarModelFixture.validCarInfo();

        // Act & Assert
        expect(carInfo1, equals(carInfo2));
        expect(carInfo1.hashCode, equals(carInfo2.hashCode));
      });

      test('should not be equal when properties are different', () {
        // Arrange
        final carInfo1 = CarModelFixture.validCarInfo();
        final carInfo2 = const CarInfoModel(
          id: 2,
          feedback: 'Different feedback',
          valuatedAt: '2023-01-01T00:00:00Z',
          requestedAt: '2023-01-01T00:00:00Z',
          createdAt: '2023-01-01T00:00:00Z',
          updatedAt: '2023-01-01T00:00:00Z',
          make: 'Honda',
          model: 'Civic',
          externalId: 'different-id',
          sellerUser: 'different-seller',
          price: 20000,
          positiveCustomerFeedback: false,
          uuidAuction: 'different-auction',
          inspectorRequestedAt: '2023-01-01T00:00:00Z',
          origin: 'different-origin',
          estimationRequestId: 'different-request',
        );

        // Act & Assert
        expect(carInfo1, isNot(equals(carInfo2)));
      });
    });
  });
}
