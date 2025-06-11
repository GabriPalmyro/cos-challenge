import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';

class CarModelFixture {
  CarModelFixture._();
  
  static CarModel validCar() => const CarModel(
        make: 'Toyota',
        model: 'Camry',
        containerName: 'test-container',
        similarity: 95,
        externalId: 'ext-123',
      );

  static CarInfoModel validCarInfo() => const CarInfoModel(
        id: 1,
        feedback: 'Good condition',
        valuatedAt: '2023-01-01T00:00:00Z',
        requestedAt: '2023-01-01T00:00:00Z',
        createdAt: '2023-01-01T00:00:00Z',
        updatedAt: '2023-01-01T00:00:00Z',
        make: 'Toyota',
        model: 'Camry',
        externalId: 'ext-123',
        sellerUser: 'seller123',
        price: 25000,
        positiveCustomerFeedback: true,
        uuidAuction: 'auction-uuid-123',
        inspectorRequestedAt: '2023-01-01T00:00:00Z',
        origin: 'dealer',
        estimationRequestId: 'est-req-123',
      );

  static List<CarModel> multipleValidCars() => [
        const CarModel(
          make: 'Toyota',
          model: 'Camry',
          containerName: 'container-1',
          similarity: 95,
          externalId: 'ext-1',
        ),
        const CarModel(
          make: 'Honda',
          model: 'Civic',
          containerName: 'container-2',
          similarity: 90,
          externalId: 'ext-2',
        ),
      ];

  static Map<String, dynamic> validCarInfoJson() => {
        'id': 1,
        'feedback': 'Good condition',
        'valuatedAt': '2023-01-01T00:00:00Z',
        'requestedAt': '2023-01-01T00:00:00Z',
        'createdAt': '2023-01-01T00:00:00Z',
        'updatedAt': '2023-01-01T00:00:00Z',
        'make': 'Toyota',
        'model': 'Camry',
        'externalId': 'ext-123',
        '_fk_sellerUser': 'seller123',
        'price': 25000,
        'positiveCustomerFeedback': true,
        '_fk_uuid_auction': 'auction-uuid-123',
        'inspectorRequestedAt': '2023-01-01T00:00:00Z',
        'origin': 'dealer',
        'estimationRequestId': 'est-req-123',
      };

  static Map<String, dynamic> validCarJson() => {
        'make': 'Toyota',
        'model': 'Camry',
        'containerName': 'test-container',
        'similarity': 95,
        'externalId': 'ext-123',
      };
}
