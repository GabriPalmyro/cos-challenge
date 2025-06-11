import 'dart:convert';

import 'package:cos_challenge/app/common/auth/data/model/user_model.dart';
import 'package:cos_challenge/app/common/auth/domain/boundary/auth_data_source.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_data_source.dart';
import 'package:cos_challenge/app/features/home/domain/boundary/car_search_repository.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_car_by_vin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class MockCarSearchRepository extends Mock implements CarSearchRepository {}

class MockCarDataSource extends Mock implements CarDataSource {}

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late GetCarByVinUseCaseImpl useCase;
  late MockCarSearchRepository mockCarSearchRepository;
  late MockCarDataSource mockCarDataSource;
  late MockAuthDataSource mockAuthDataSource;

  late UserModel mockUser;
  late CarInfoModel mockCarInfo;
  late List<CarInfoModel> mockCachedResults;
  late List<CarModel> mockMultipleResponses;

  const testVin = '1HGBH41JXMN109186';

  setUp(() {
    mockCarSearchRepository = MockCarSearchRepository();
    mockCarDataSource = MockCarDataSource();
    mockAuthDataSource = MockAuthDataSource();
    useCase = GetCarByVinUseCaseImpl(
      mockCarSearchRepository,
      mockCarDataSource,
      mockAuthDataSource,
    );

    mockUser = const UserModel(name: 'Test User', email: 'test@example.com');
    mockCarInfo = CarInfoModel.fromJson(jsonDecode(carInfoResponse));
    mockCachedResults = jsonDecode(cachedResultResponse).map<CarInfoModel>((json) => CarInfoModel.fromJson(json)).toList() as List<CarInfoModel>;
    mockMultipleResponses = jsonDecode(multipleOptionResponse).map<CarModel>((json) => CarModel.fromJson(json)).toList() as List<CarModel>;
  });

  group('GetCarByVinUseCase', () {
    test('should return CarSearchSuccess and save to cache when search succeeds', () async {
      // Arrange
      final successResult = CarSearchSuccess(mockCarInfo);
      when(() => mockAuthDataSource.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(() => mockCarSearchRepository.getCarByVin(testVin, mockUser.email)).thenAnswer((_) async => successResult);
      when(() => mockCarDataSource.getCacheOnCache()).thenAnswer((_) async => []);
      when(() => mockCarDataSource.saveCacheOnCache(mockCarInfo)).thenAnswer((_) async => {});

      // Act
      final result = await useCase.call(testVin);

      // Assert
      expect(result, isA<CarSearchSuccess>());
      verify(() => mockCarDataSource.saveCacheOnCache(mockCarInfo)).called(1);
    });

    test('should return CarMultipleChoices with cached results when multiple cars found', () async {
      // Arrange
      final multipleChoicesResult = CarMultipleChoices(mockMultipleResponses);
      when(() => mockAuthDataSource.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(() => mockCarSearchRepository.getCarByVin(testVin, mockUser.email)).thenAnswer((_) async => multipleChoicesResult);
      when(() => mockCarDataSource.getCacheOnCache()).thenAnswer((_) async => mockCachedResults);

      // Act
      final result = await useCase.call(testVin);

      // Assert
      expect(result, isA<CarMultipleChoices>());
      final multipleChoices = result as CarMultipleChoices;
      expect(multipleChoices.lastSearchResults, equals(mockCachedResults));
    });

    test('should return CarSearchFailure with cached results when search fails and cache exists', () async {
      // Arrange
      const error = CarsNotFoundError();
      const failureResult = CarSearchFailure(error);
      when(() => mockAuthDataSource.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(() => mockCarSearchRepository.getCarByVin(testVin, mockUser.email)).thenAnswer((_) async => failureResult);
      when(() => mockCarDataSource.getCacheOnCache()).thenAnswer((_) async => mockCachedResults);

      // Act
      final result = await useCase.call(testVin);

      // Assert
      expect(result, isA<CarSearchFailure>());
      final failure = result as CarSearchFailure;
      expect(failure.cachedResults, equals(mockCachedResults));
    });

    test('should return original CarSearchFailure when search fails and no cache exists', () async {
      // Arrange
      const error = CarsNotFoundError();
      const failureResult = CarSearchFailure(error);
      when(() => mockAuthDataSource.getCurrentUser()).thenAnswer((_) async => mockUser);
      when(() => mockCarSearchRepository.getCarByVin(testVin, mockUser.email)).thenAnswer((_) async => failureResult);
      when(() => mockCarDataSource.getCacheOnCache()).thenAnswer((_) async => []);

      // Act
      final result = await useCase.call(testVin);

      // Assert
      expect(result, equals(failureResult));
    });

    test('should return CarSearchFailure with CarsNotFoundError when generic exception occurs', () async {
      // Arrange
      when(() => mockAuthDataSource.getCurrentUser()).thenThrow(Exception('Generic error'));
      when(() => mockCarDataSource.getCacheOnCache()).thenAnswer((_) async => mockCachedResults);

      // Act
      final result = await useCase.call(testVin);

      // Assert
      expect(result, isA<CarSearchFailure>());
      final failure = result as CarSearchFailure;
      expect(failure.error, isA<CarsNotFoundError>());
      expect(failure.cachedResults, equals(mockCachedResults));
    });

    test('should return CarSearchFailure with original CarsErrors when CarsErrors exception occurs', () async {
      // Arrange
      const carsError = CarsNotFoundError();
      when(() => mockAuthDataSource.getCurrentUser()).thenThrow(carsError);
      when(() => mockCarDataSource.getCacheOnCache()).thenAnswer((_) async => mockCachedResults);

      // Act
      final result = await useCase.call(testVin);

      // Assert
      expect(result, isA<CarSearchFailure>());
      final failure = result as CarSearchFailure;
      expect(failure.error, equals(carsError));
      expect(failure.cachedResults, equals(mockCachedResults));
    });
  });
}
