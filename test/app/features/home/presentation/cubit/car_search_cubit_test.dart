import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_info_model.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_cached_cars.dart';
import 'package:cos_challenge/app/features/home/domain/use_case/get_car_by_vin.dart';
import 'package:cos_challenge/app/features/home/presentation/cubit/car_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

class MockGetCarByVinUseCase extends Mock implements GetCarByVinUseCase {}

class MockGetCachedCarsUseCase extends Mock implements GetCachedCarsUseCase {}

void main() {
  late CarSearchCubit cubit;
  late MockGetCarByVinUseCase mockGetCarByVinUseCase;
  late MockGetCachedCarsUseCase mockGetCachedCarsUseCase;

  setUp(() {
    mockGetCarByVinUseCase = MockGetCarByVinUseCase();
    mockGetCachedCarsUseCase = MockGetCachedCarsUseCase();
    cubit = CarSearchCubit(mockGetCarByVinUseCase, mockGetCachedCarsUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('CarSearchCubit Test |', () {
    const testVin = '1234567890';
    final testCarInfo = CarInfoModel.fromJson(jsonDecode(carInfoResponse));
    final testCarsList = (jsonDecode(multipleOptionResponse) as List).map((car) => CarModel.fromJson(car)).toList();
    final testCachedCars = (jsonDecode(cachedResultResponse) as List).map((car) => CarInfoModel.fromJson(car)).toList();

    test('initial state is CarSearchInitial', () {
      expect(cubit.state, const CarSearchInitial());
    });

    group('searchCarByVin', () {
      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchLoading, CarSearchLoaded] when search succeeds',
        build: () {
          when(() => mockGetCarByVinUseCase.call(testVin)).thenAnswer(
            (_) async => CarSearchSuccess(
              testCarInfo,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.searchCarByVin(testVin),
        expect: () => [
          const CarSearchLoading(),
          CarSearchLoaded(testCarInfo),
        ],
      );

      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchLoading, MultipleCarSearchLoaded] when multiple cars found',
        build: () {
          when(() => mockGetCarByVinUseCase.call(testVin)).thenAnswer(
            (_) async => CarMultipleChoices(
              testCarsList,
              lastSearchResults: testCachedCars,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.searchCarByVin(testVin),
        expect: () => [
          const CarSearchLoading(),
          MultipleCarSearchLoaded(testCarsList, testCachedCars),
        ],
      );

      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchLoading, CarSearchError] when search fails',
        build: () {
          when(() => mockGetCarByVinUseCase.call(testVin)).thenAnswer(
            (_) async => CarSearchFailure(
              const CarsNotFoundError(),
              cachedResults: testCachedCars,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.searchCarByVin(testVin),
        expect: () => [
          const CarSearchLoading(),
          CarSearchError(const CarsNotFoundError(), cachedResults: testCachedCars),
        ],
      );

      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchLoading, CarSearchError] when unknown result type',
        build: () {
          when(() => mockGetCarByVinUseCase.call(testVin)).thenAnswer(
            (_) async => CarSearchFailure(
              const CarsNotFoundError(),
              cachedResults: testCachedCars,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.searchCarByVin(testVin),
        expect: () => [
          const CarSearchLoading(),
          CarSearchError(const CarsNotFoundError(), cachedResults: testCachedCars),
        ],
      );

      blocTest<CarSearchCubit, CarSearchState>(
        'emits [CarSearchLoading, CarSearchError] when exception is thrown',
        build: () {
          when(() => mockGetCarByVinUseCase.call(testVin)).thenThrow(
            Exception(
              'Network error',
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.searchCarByVin(testVin),
        expect: () => [
          const CarSearchLoading(),
          const CarSearchError(CarsNotFoundError()),
        ],
      );
    });

    group('loadCachedCars', () {
      blocTest<CarSearchCubit, CarSearchState>(
        'emits CarSearchInitial with cached cars when load succeeds',
        build: () {
          when(() => mockGetCachedCarsUseCase.call()).thenAnswer((_) async => testCachedCars);
          return cubit;
        },
        act: (cubit) => cubit.loadCachedCars(),
        expect: () => [
          CarSearchInitial(lastSearchResults: testCachedCars),
        ],
      );

      blocTest<CarSearchCubit, CarSearchState>(
        'emits CarSearchInitial with empty list when no cached cars',
        build: () {
          when(() => mockGetCachedCarsUseCase.call()).thenAnswer((_) async => <CarInfoModel>[]);
          return cubit;
        },
        act: (cubit) => cubit.loadCachedCars(),
        expect: () => [
          const CarSearchInitial(lastSearchResults: <CarInfoModel>[]),
        ],
      );
    });

    test('calls GetCarByVinUseCase with correct VIN', () async {
      when(() => mockGetCarByVinUseCase.call(testVin)).thenAnswer((_) async => CarSearchSuccess(testCarInfo));

      await cubit.searchCarByVin(testVin);

      verify(() => mockGetCarByVinUseCase.call(testVin)).called(1);
    });

    test('calls GetCachedCarsUseCase when loading cached cars', () async {
      when(() => mockGetCachedCarsUseCase.call()).thenAnswer((_) async => testCachedCars);

      await cubit.loadCachedCars();

      verify(() => mockGetCachedCarsUseCase.call()).called(1);
    });
  });
}
