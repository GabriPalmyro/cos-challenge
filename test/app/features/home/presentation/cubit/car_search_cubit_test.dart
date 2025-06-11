import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_cached_cars.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_car_by_vin.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/car_model_fixture.dart';

class MockGetCarByVinUseCase extends Mock implements GetCarByVinUseCase {}
class MockGetCachedCarsUseCase extends Mock implements GetCachedCarsUseCase {}

void main() {
  group('CarSearchCubit', () {
    late MockGetCarByVinUseCase mockGetCarByVinUseCase;
    late MockGetCachedCarsUseCase mockGetCachedCarsUseCase;
    late CarSearchCubit carSearchCubit;

    setUp(() {
      mockGetCarByVinUseCase = MockGetCarByVinUseCase();
      mockGetCachedCarsUseCase = MockGetCachedCarsUseCase();
      carSearchCubit = CarSearchCubit(
        mockGetCarByVinUseCase,
        mockGetCachedCarsUseCase,
      );
    });

    tearDown(() {
      carSearchCubit.close();
    });

    test('initial state is CarSearchInitial', () {
      expect(carSearchCubit.state, equals(const CarSearchInitial()));
    });

    group('searchCarByVin', () {
      const testVin = '1HGBH41JXMN109186';

      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchLoading, CarSearchLoaded] when search is successful',
        build: () {
          when(() => mockGetCarByVinUseCase.call(any()))
              .thenAnswer((_) async => CarSearchSuccess(CarModelFixture.validCarInfo()));
          return carSearchCubit;
        },
        act: (cubit) => cubit.searchCarByVin(testVin),
        expect: () => [
          const CarSearchLoading(),
          CarSearchLoaded(CarModelFixture.validCarInfo()),
        ],
        verify: (_) {
          verify(() => mockGetCarByVinUseCase.call(testVin)).called(1);
        },
      );

      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchLoading, MultipleCarSearchLoaded] when multiple cars found',
        build: () {
          when(() => mockGetCarByVinUseCase.call(any()))
              .thenAnswer((_) async => CarMultipleChoices(CarModelFixture.multipleValidCars()));
          return carSearchCubit;
        },
        act: (cubit) => cubit.searchCarByVin(testVin),
        expect: () => [
          const CarSearchLoading(),
          MultipleCarSearchLoaded(CarModelFixture.multipleValidCars()),
        ],
        verify: (_) {
          verify(() => mockGetCarByVinUseCase.call(testVin)).called(1);
        },
      );

      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchLoading, CarSearchError] when search fails',
        build: () {
          final error = CarsNotFoundError();
          when(() => mockGetCarByVinUseCase.call(any()))
              .thenAnswer((_) async => CarSearchFailure(error));
          return carSearchCubit;
        },
        act: (cubit) => cubit.searchCarByVin(testVin),
        expect: () => [
          const CarSearchLoading(),
          isA<CarSearchError>()
              .having((state) => state.error, 'error', isA<CarsNotFoundError>()),
        ],
        verify: (_) {
          verify(() => mockGetCarByVinUseCase.call(testVin)).called(1);
        },
      );
    });

    group('loadCachedCars', () {
      blocTest<CarSearchCubit, CarSearchState>(
        'emits [MultipleCarSearchLoaded] when cached cars loaded successfully',
        build: () {
          when(() => mockGetCachedCarsUseCase.call())
              .thenAnswer((_) async => CarModelFixture.multipleValidCars());
          return carSearchCubit;
        },
        act: (cubit) => cubit.loadCachedCars(),
        expect: () => [
          MultipleCarSearchLoaded(CarModelFixture.multipleValidCars()),
        ],
        verify: (_) {
          verify(() => mockGetCachedCarsUseCase.call()).called(1);
        },
      );

      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchInitial] when loading cached cars fails',
        build: () {
          when(() => mockGetCachedCarsUseCase.call())
              .thenThrow(Exception('Failed to load cached cars'));
          return carSearchCubit;
        },
        act: (cubit) => cubit.loadCachedCars(),
        expect: () => [
          const CarSearchInitial(),
        ],
        verify: (_) {
          verify(() => mockGetCachedCarsUseCase.call()).called(1);
        },
      );
    });
  });
}
