import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cos_challenge/app/common/client/cos_client.dart';
import 'package:cos_challenge/app/core/errors/cars_errors.dart';
import 'package:cos_challenge/app/core/types/car_search_result.dart';
import 'package:cos_challenge/app/features/home/data/model/car_model.dart';
import 'package:cos_challenge/app/features/home/data/repository/car_search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/car_model_fixture.dart';

class MockHttpClient extends Mock implements http.BaseClient {}

void main() {
  late CarSearchRepositoryImpl repository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = CarSearchRepositoryImpl(httpClient: mockHttpClient);
  });

  group('CarSearchRepositoryImpl', () {
    const testVin = '1HGBH41JXMN109186';
    const testUserEmail = 'test@example.com';

    group('getCarByVin', () {
      test('should return CarSearchSuccess when single car is found', () async {
        // Arrange
        final carInfo = CarModelFixture.validCarInfo();
        final responseBody = jsonEncode(carInfo.toJson());

        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response(responseBody, HttpStatus.ok));

        // Act
        final result = await repository.getCarByVin(testVin, testUserEmail);

        // Assert
        expect(result, isA<CarSearchSuccess>());
        final success = result as CarSearchSuccess;
        expect(success.carInfo.make, carInfo.make);
        expect(success.carInfo.model, carInfo.model);
        expect(success.carInfo.externalId, carInfo.externalId);

        verify(
          () => mockHttpClient.get(
            Uri.https('anyUrl'),
            headers: {CosChallenge.user: testUserEmail},
          ),
        ).called(1);
      });

      test('should return CarMultipleChoices when multiple cars are found', () async {
        // Arrange
        final cars = [
          CarModelFixture.validCar(),
          const CarModel(
            make: 'Honda',
            model: 'Civic',
            containerName: 'different-container',
            similarity: 95,
            externalId: 'DIFFERENT123456789',
          ),
        ];
        final responseBody = jsonEncode(cars.map((c) => c.toJson()).toList());

        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response(responseBody, HttpStatus.multipleChoices));

        // Act
        final result = await repository.getCarByVin(testVin, testUserEmail);

        // Assert
        expect(result, isA<CarMultipleChoices>());
        final multipleChoices = result as CarMultipleChoices;
        expect(multipleChoices.carsList.length, 2);

        // Should be sorted by similarity (descending)
        expect(multipleChoices.carsList.first.similarity, 95);
        expect(multipleChoices.carsList.last.similarity, 95);
      });

      test('should throw CarMaintenceDelayException when status is bad request', () async {
        // Arrange
        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response('Bad Request', HttpStatus.badRequest));

        // Act & Assert
        expect(
          () => repository.getCarByVin(testVin, testUserEmail),
          throwsA(isA<CarMaintenceDelayException>()),
        );
      });

      test('should return CarSearchFailure when server returns error', () async {
        // Arrange
        const errorMessage = 'Car not found';
        final responseBody = jsonEncode({'message': errorMessage});

        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response(responseBody, HttpStatus.notFound));

        // Act
        final result = await repository.getCarByVin(testVin, testUserEmail);

        // Assert
        expect(result, isA<CarSearchFailure>());
        final failure = result as CarSearchFailure;
        expect(failure.error.message, errorMessage);
      });

      test('should return CarSearchFailure with default message when no message provided', () async {
        // Arrange
        const responseBody = '{}';

        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response(responseBody, HttpStatus.internalServerError));

        // Act
        final result = await repository.getCarByVin(testVin, testUserEmail);

        // Assert
        expect(result, isA<CarSearchFailure>());
        final failure = result as CarSearchFailure;
        expect(failure.error.message, 'Unknown server error');
      });

      test('should throw CarsSearchTimeoutException on timeout', () async {
        // Arrange
        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenThrow(TimeoutException('Timeout', const Duration(seconds: 30)));

        // Act & Assert
        expect(
          () => repository.getCarByVin(testVin, testUserEmail),
          throwsA(isA<CarsSearchTimeoutException>()),
        );
      });

      test('should throw CarsClientException on client exception', () async {
        // Arrange
        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenThrow(http.ClientException('Client error'));

        // Act & Assert
        expect(
          () => repository.getCarByVin(testVin, testUserEmail),
          throwsA(isA<CarsClientException>()),
        );
      });

      test('should rethrow CarsErrors exceptions', () async {
        // Arrange
        final customError = CarMaintenceDelayException();
        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenThrow(customError);

        // Act & Assert
        expect(
          () => repository.getCarByVin(testVin, testUserEmail),
          throwsA(customError),
        );
      });
    });
  });
}
