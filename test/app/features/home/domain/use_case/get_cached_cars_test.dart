import 'dart:convert';

import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_data_source.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_cached_cars.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class MockCarDataSource extends Mock implements CarDataSource {}

void main() {
  late GetCachedCarsUseCaseImpl useCase;
  late MockCarDataSource mockCarDataSource;

  setUp(() {
    mockCarDataSource = MockCarDataSource();
    useCase = GetCachedCarsUseCaseImpl(mockCarDataSource);
  });

  group('GetCachedCarsUseCaseImpl Test |', () {
    test('should return list of cars when data source returns data successfully', () async {
      // Arrange
      final expectedCars = (jsonDecode(cachedResultResponse) as List).map((car) => CarInfoModel.fromJson(car)).toList();

      when(() => mockCarDataSource.getCacheOnCache()).thenAnswer((_) async => expectedCars);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, equals(expectedCars));
      verify(() => mockCarDataSource.getCacheOnCache()).called(1);
    });

    test('should return empty list when data source throws exception', () async {
      // Arrange
      when(() => mockCarDataSource.getCacheOnCache()).thenThrow(Exception('Cache error'));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isEmpty);
      verify(() => mockCarDataSource.getCacheOnCache()).called(1);
    });

    test('should return empty list when data source returns empty list', () async {
      // Arrange
      when(() => mockCarDataSource.getCacheOnCache()).thenAnswer((_) async => []);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isEmpty);
      verify(() => mockCarDataSource.getCacheOnCache()).called(1);
    });
  });
}
