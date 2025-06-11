import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_search_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCarSearchRepository extends Mock implements CarSearchRepository {
  static void setupMockSuccess({
    CarSearchResult? result,
  }) {
    final mockRepository = MockCarSearchRepository();
    
    final defaultCarInfo = const CarInfoModel(
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
    
    when(() => mockRepository.getCarByVin(any(), any()))
        .thenAnswer((_) async => result ?? CarSearchSuccess(defaultCarInfo));
  }

  static void setupMockFailure() {
    final mockRepository = MockCarSearchRepository();
    
    when(() => mockRepository.getCarByVin(any(), any()))
        .thenThrow(Exception('Failed to search car'));
  }
}
