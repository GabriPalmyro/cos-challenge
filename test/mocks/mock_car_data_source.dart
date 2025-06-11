import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockCarDataSource extends Mock implements CarDataSource {
  static void setupMockSuccess({
    List<CarModel>? cachedCars,
  }) {
    final mockCarDataSource = MockCarDataSource();
    
    when(() => mockCarDataSource.getCacheOnCache())
        .thenAnswer((_) async => cachedCars ?? []);
    
    when(() => mockCarDataSource.saveCacheOnCache(any()))
        .thenAnswer((_) async {});
    
    when(() => mockCarDataSource.deleteCacheOnCache())
        .thenAnswer((_) async {});
  }

  static void setupMockFailure() {
    final mockCarDataSource = MockCarDataSource();
    
    when(() => mockCarDataSource.getCacheOnCache())
        .thenThrow(Exception('Failed to get cached cars'));
    
    when(() => mockCarDataSource.saveCacheOnCache(any()))
        .thenThrow(Exception('Failed to save cached cars'));
    
    when(() => mockCarDataSource.deleteCacheOnCache())
        .thenThrow(Exception('Failed to delete cached cars'));
  }
}
